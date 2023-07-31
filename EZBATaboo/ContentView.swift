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
            ZStack {
                Color(red: 108/255, green: 136/255, blue: 159/255)
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    
                    Image("wordsmithlogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenWidth * 0.95)
                    
                    Spacer()
                    
                    NavigationLink {
                        CategoriesView()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(red: 251/255, green: 129/255, blue: 28/255))
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 3)
                                .foregroundColor(.black)
                            HStack{
                                Text("Start Game").font(.title)
                                Image(systemName: "play.circle").font(.title)
                            }.foregroundColor(.black)
                        }
                        .frame(width: UIScreen.screenWidth/1.65, height: UIScreen.screenHeight/10)
                    }
                    
                    NavigationLink {
                        CustomCardView()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(red: 251/255, green: 129/255, blue: 28/255))
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 3)
                                .foregroundColor(.black)
                            HStack{
                                Text("Create Custom Cards").font(.title2)
                                Image(systemName: "menucard").font(.title)
                            }.foregroundColor(.black)
                                                }
                        .frame(width: UIScreen.screenWidth/1.65, height: UIScreen.screenHeight/10)
                    }
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .preferredColorScheme(.light)
        .tint(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
