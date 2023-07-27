//
//  ScoreView.swift
//  EZBATaboo
//
//  Created by Furkan Eken on 9.07.2023.
//

import SwiftUI

struct ScoreView: View {
    @StateObject var viewModel = ViewModel(teamScore: 5, teamName: "Default")
    
    var body: some View {
        ZStack {
            Color(red: 108/255, green: 136/255, blue: 159/255)
                .ignoresSafeArea()
            VStack{
                Spacer()
                
                Text("Final Score: \(String(viewModel.teamScore))").font(.largeTitle)
                
                Spacer()
                
                HStack{
                    NavigationLink(destination: CategoriesView()) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color(red: 203/255, green: 129/255, blue: 98/255))
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(lineWidth: 3)
                                .fill(.black)
                            HStack{
                                Text("Play Again")
                            }
                            .font(.title3)
                            .bold()
                            .foregroundColor(.black)
                        }.frame(height: UIScreen.main.bounds.height * 0.075)
                    }
                    .padding(.horizontal)
                    
                    NavigationLink(destination: ContentView()) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color(red: 203/255, green: 129/255, blue: 98/255))
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(lineWidth: 3)
                                .fill(.black)
                            Text("Main Menu")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.black)
                        }.frame(height: UIScreen.main.bounds.height * 0.075)
                    }
                    .padding(.horizontal)
                }
                .offset(y: viewModel.adReady ? 0 : 150)
                .padding()
            }
            .onAppear(perform: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            viewModel.adReady = true
                        }
                    })
            .navigationBarBackButtonHidden(true)
            .onDisappear(){
                viewModel.callAd()
        }
        }
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView()
    }
}
