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
    @State private var showSuccessMessage = false
    
    var body: some View {
        NavigationView{
            ZStack {
                Color(red: 108/255, green: 136/255, blue: 159/255)
                    .ignoresSafeArea()
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
                        if showSuccessMessage {
                            SuccessView()
                        }
                    }.frame(width: UIScreen.screenWidth * 0.85, height: UIScreen.screenHeight * 0.65)
                    
                    HStack{
                        Spacer()
                        Button {
                            let customWord = TabooWord(key: viewModel.cardName, forbidden_words: viewModel.forbiddenWords)
                            viewModel.writeData(customWord, "custom")
                            successMessage()
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color(red: 203/255, green: 129/255, blue: 98/255))
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(lineWidth: 3)
                                    .fill(.black)
                                Text("Add")
                                    .font(.title3)
                                    .bold()
                                    .foregroundColor(.black)
                            }
                        }.frame(height: UIScreen.main.bounds.height * 0.075)
                        Spacer()
                        Button {
                            isShowingSheet = true
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color(red: 203/255, green: 129/255, blue: 98/255))
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(lineWidth: 3)
                                    .fill(.black)
                                Text("Card List")
                                    .font(.headline)
                                    .foregroundColor(.black)
                            }
                        }.frame(height: UIScreen.main.bounds.height * 0.075)
                        Spacer()
                    }.padding(15)
                }.sheet(isPresented: $isShowingSheet){ListView()}
            }
        }
    }
    func successMessage(){
        showSuccessMessage = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            withAnimation(){
                showSuccessMessage = false
            }
        }
    }
}

struct CustomCardView_Previews: PreviewProvider {
    static var previews: some View {
        CustomCardView()
    }
}
