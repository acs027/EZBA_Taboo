//
//  CustomCardView.swift
//  EZBATaboo
//
//  Created by Furkan Eken on 18.07.2023.
//

import SwiftUI

struct CustomCardView: View {
    @StateObject var viewModel = ViewModel()
    @State private var isShowingSheet = false
    
    var body: some View {
        NavigationView{
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10).fill(.gray)
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 5)
                        .fill(.black)
                        .zIndex(1)
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10).fill(.purple)
                            TextField(viewModel.cardName ,text: $viewModel.cardName)
                                .multilineTextAlignment(.center)
                                .font(.largeTitle)
                                .bold()
                            Rectangle().fill(.black).frame(height: 5)
                                .offset(y: UIScreen.screenHeight * 0.10)
                        }.frame(height: UIScreen.screenHeight * 0.20)
                        
                        
                        Spacer()
                        
                        ForEach(0..<viewModel.forbiddenWords.count, id:\.self) { index in
                            TextField("Forbidden Word \(String(index+1))" ,text: $viewModel.forbiddenWords[index])
                                .multilineTextAlignment(.center)
                                .font(.title)
                                .padding(1)
                        }
                        
                        Spacer()
                    }
                }.frame(width: UIScreen.screenWidth * 0.85, height: UIScreen.screenHeight * 0.65)
                
                Button {
                    let customWord = TabooWord(key: viewModel.cardName, forbidden_words: viewModel.forbiddenWords)
                    viewModel.writeData(customWord, "custom")
                } label: {
                    Text("Add")
                }.padding(.top)
            }
            .toolbar{
                ToolbarItem(placement: .bottomBar){
                    Button {
                        isShowingSheet = true
                    } label: {
                        Text("Card List")
                    }
                }
            }
            .sheet(isPresented: $isShowingSheet){ListView()}
        }
    }
}

struct CustomCardView_Previews: PreviewProvider {
    static var previews: some View {
        CustomCardView()
    }
}
