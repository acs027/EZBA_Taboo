//
//  ContentView.swift
//  EZBATaboo
//
//  Created by ali cihan on 29.05.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    CategoriesView()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.orange)
                        HStack{
                            Text("Start Game")
                            Image(systemName: "play.circle")
                        }
                    }
                    .frame(width: UIScreen.screenWidth/1.65, height: UIScreen.screenHeight/10)
                }
                
                NavigationLink {
                    CustomCardView()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.orange)
                        HStack{
                            Text("Create Custom Cards")
                            Image(systemName: "menucard")
                        }
                                            }
                    .frame(width: UIScreen.screenWidth/1.65, height: UIScreen.screenHeight/10)
                }
            }
        }.navigationBarBackButtonHidden(true)
            .preferredColorScheme(.light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
