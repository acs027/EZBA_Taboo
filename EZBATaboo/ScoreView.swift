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
        VStack{
            Spacer()
            
//            Text(viewModel.teamName)
            Text("Final Score: \(String(viewModel.teamScore))").font(.largeTitle)
            
            Spacer()
            
            HStack{
//                Button {
//                    viewModel.callAd()
//                } label: {
//                    Text("Deneme")
//                }
                NavigationLink(destination: CategoriesView()) {
                    Text("Play Again")
                }
                .padding(.horizontal)
                
                NavigationLink(destination: ContentView()) {
                    Text("Main Menu")
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

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView()
    }
}
