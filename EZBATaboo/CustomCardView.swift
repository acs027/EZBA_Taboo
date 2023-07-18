//
//  CustomCardView.swift
//  EZBATaboo
//
//  Created by Furkan Eken on 18.07.2023.
//

import SwiftUI

struct CustomCardView: View {
    @StateObject var viewModel = ViewModel()
    
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
                        
                        ForEach(viewModel.forbiddenWords, id:\.self) { fbword in
                            let index = viewModel.forbiddenWords.firstIndex(of: fbword)
                            TextField(fbword ,text: $viewModel.forbiddenWords[index!])
                                .multilineTextAlignment(.center)
                                .font(.title)
                                .padding(1)
                        }
                        
                        Spacer()
                    }
                }.frame(width: UIScreen.screenWidth * 0.85, height: UIScreen.screenHeight * 0.65)
                
                Button {
                    viewModel.resetCard()
                } label: {
                    Text("Add")
                }.padding(.top)
            }
        }
    }
}

struct CustomCardView_Previews: PreviewProvider {
    static var previews: some View {
        CustomCardView()
    }
}
