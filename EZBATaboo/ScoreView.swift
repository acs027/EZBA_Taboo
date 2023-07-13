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
                NavigationLink(destination: CategoriesView()) {
                    Text("Play Again")
                }
                .padding(.horizontal)
                
                NavigationLink(destination: ContentView()) {
                    Text("Main Menu")
                }
                .padding(.horizontal)
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView()
    }
}
