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
    @StateObject var viewModel = ViewModel(timeLimit: 60, questionLimit: 10)
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let categories: Set<String>
    
    var body: some View {
        if viewModel.gameEnded {
            ScoreView(viewModel: ScoreView.ViewModel.init(teamScore: viewModel.teamScore))
        } else {
            ZStack {
                Color(red: 108/255, green: 136/255, blue: 159/255)
                    .ignoresSafeArea()
                
                Button {
                    viewModel.loadGame()
                    viewModel.startTimer()
                    viewModel.gameStarted = true
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                        VStack{
                            Text("Ready!")
                                .font(.title)
                                .foregroundColor(.white)
                            Text("(press to start)")
                                .font(.body)
                                .foregroundColor(.white)
                        }
                    }
                }
                .opacity(viewModel.gameStarted ? 0 : 1)
                
                VStack {
                    
                    Spacer()
                    HStack(alignment: .center){
                            Text("Score: \(String(viewModel.teamScore))")
                            .frame(width: UIScreen.screenWidth * 0.25)
                            
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
                                Circle().fill(viewModel.currentTime > 10 ? .green : .red).frame(width: 41, height: 41)
                                ProgressBar(timeLimit: $viewModel.timeLimit, currentTime: $viewModel.currentTime)
                                Text(String(viewModel.currentTime))
                            }.frame(width: 50, height: 50)
                            .frame(width: UIScreen.screenWidth * 0.25)
                            
                        }
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
            .onReceive(timer) { fired in
                if viewModel.gameStarted {
                    viewModel.updateTimer()
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(categories: ["animals"])
    }
}
