//
//  GameView.swift
//  EZBATaboo
//
//  Created by ali cihan on 1.06.2023.
//

import SwiftUI

struct GameView: View {
    @StateObject var viewModel = ViewModel()
    let categories: Set<String>
    
    var body: some View {
        
      
        
        ZStack {
            
            Button {
                viewModel.gameStarted = true
                viewModel.loadGame()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                    Text("Start")
                        .foregroundColor(.white)
                }
            }
            .opacity(viewModel.gameStarted ? 0 : 1)
            
            ForEach(viewModel.gameTaboo, id:\.key) { word in
                ZStack {
                    RoundedRectangle(cornerRadius: 10).fill(.gray)
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10).fill(.purple)
                            Text(word.key)
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 10).fill(.purple)
                            HStack {
                                ForEach(word.forbidden_words, id:\.self) { fbword in
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10).fill(.blue)
                                        Text(fbword)
                                            .minimumScaleFactor(0.4)
                                    }
                                }
                            }
                        }
                    }.padding()
                }
                .opacity(viewModel.gameStarted ? 1 : 0)
                .frame(width: UIScreen.screenWidth * 0.9, height: UIScreen.screenHeight * 0.9)
                .onTapGesture {
                    viewModel.nextCard()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
        .onAppear {
            viewModel.loadData(categories: categories)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(categories: ["animals"])
    }
}
