//
//  GameView.swift
//  EZBATaboo
//
//  Created by ali cihan on 1.06.2023.
//

import SwiftUI

struct tabooWordRect: View {
    let word: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.blue)
            Text(word)
        }
    }
}

struct GameView: View {
    @StateObject var viewModel = ViewModel(teamName: "Team Name", timeLimit: 60, questionLimit: 10)
    let categories: Set<String>
    
    var body: some View {
        if viewModel.gameEnded {
            ScoreView(viewModel: ScoreView.ViewModel.init(teamScore: viewModel.teamScore, teamName: viewModel.teamName))
        } else {
            ZStack {
                Color(red: 108/255, green: 136/255, blue: 159/255)
                    .ignoresSafeArea()
                
                Button {
                    viewModel.gameStarted = true
                    viewModel.loadGame()
                    viewModel.startTimer()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                        Text("Ready!")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                }
                .opacity(viewModel.gameStarted ? 0 : 1)
                
                VStack {
                    
                    Spacer()
                        HStack{
//                            Text(viewModel.teamName)
                            
                            Text("Score: \(String(viewModel.teamScore))")
                            
                            Spacer()
                            
                            Button {
                                viewModel.pauseGame()
                            } label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color(red: 251/255, green: 129/255, blue: 28/255))
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(lineWidth: 2)
                                        .fill(.black)
                                    HStack{
                                        Text(viewModel.gamePaused ? "Resume" : "Pause")
                                        Image(systemName: viewModel.gamePaused ? "play.fill" : "pause")
                                    }
                                }.frame(width: UIScreen.screenWidth * 0.25, height: UIScreen.screenHeight * 0.045)
                            }
                            
                            Spacer()
                            
                            ZStack{
                                Circle().fill(viewModel.currentTime > 10 ? .green : .red).frame(width: 40)
                                Circle().stroke(lineWidth: 2).frame(width: 40)
                                Text(String(viewModel.currentTime))
                            }.frame(width: 50, height: 50)
                            
                        }.frame(width: UIScreen.screenWidth * 0.85)
                        .opacity(viewModel.gameStarted ? 1 : 0)
                        .padding(.horizontal)
                    
                    ZStack{
                        ForEach(viewModel.gameTaboo, id:\.key) { word in
                            ZStack {
                                RoundedRectangle(cornerRadius: 10).fill(.gray)
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 5)
                                    .fill(.black)
                                    .zIndex(1)
                                VStack {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10).fill(.purple)
                                        if !viewModel.gamePaused{
                                            Text(word.key)
                                                .font(.largeTitle)
                                                .bold()
                                                .padding(.horizontal)
                                                .multilineTextAlignment(.center)
                                        }
                                        Rectangle().fill(.black).frame(height: 5)
                                            .offset(y: UIScreen.screenHeight * 0.10)
                                    }.frame(height: UIScreen.screenHeight * 0.20)
                                    
                                    
                                    Spacer()
                                    if !viewModel.gamePaused{
                                        ForEach(word.forbidden_words, id:\.self) { fbword in
                                                Text(fbword)
                                                .font(.title)
                                                .padding(1)
                                                .multilineTextAlignment(.center)
                                        }
                                    }
                                    Spacer()
                                }
                            }
                            .opacity(viewModel.gameStarted ? 1 : 0)
                            .frame(width: UIScreen.screenWidth * 0.8, height: UIScreen.screenHeight * 0.7)
                        }
                    }
                    Spacer()
                    
                    HStack{
                        Button {
                            viewModel.wrongAnswer()
                            viewModel.teamScore -= 1
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(.red)
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(lineWidth: 3)
                                    .fill(.black)
                                Text("WRONG")
                                    .foregroundColor(.black)
                            }
                        }.frame(height: UIScreen.main.bounds.height * 0.075)
                        
                        Button {
                            viewModel.passCard()
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(.yellow)
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(lineWidth: 3)
                                    .fill(.black)
                                VStack{
                                    Text("PASS")
                                        .foregroundColor(.black)
                                    Text("\(String(viewModel.passCount))/3")
                                        .foregroundColor(.black)
                                }
                            }
                        }
                        .disabled(viewModel.passCount >= 3)
                        .opacity(viewModel.passCount >= 3 ? 0.5 : 1)
                        .frame(height: UIScreen.main.bounds.height * 0.075)
                        
                        Button {
                            viewModel.correctAnswer()
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(.green)
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(lineWidth: 3)
                                    .fill(.black)
                                Text("CORRECT")
                                    .foregroundColor(.black)
                            }
                        }.frame(height: UIScreen.main.bounds.height * 0.075)
                        
                    }
                    .opacity(viewModel.gameStarted ? 1 : 0)
                    .padding([.bottom, .horizontal])
                    .offset(y: viewModel.offset)
                }
            }
            .navigationBarBackButtonHidden(true)
            .ignoresSafeArea()
            .onAppear {
                viewModel.loadData(categories: categories)
                viewModel.prepareHaptics()
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(categories: ["animals"])
    }
}
