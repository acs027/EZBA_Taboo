//
//  CategoriesView.swift
//  EZBATaboo
//
//  Created by ali cihan on 31.05.2023.
//

import Foundation
import SwiftUI

struct CategoriesView: View {
    @StateObject var viewModel = ViewModel()
    @State var numberofQs = [10,15,20]
    
    let layout = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        ZStack {
            Color(red: 108/255, green: 136/255, blue: 159/255)
                .ignoresSafeArea()
            VStack {
                Text("Select one or more categories")
                    .font(.title2)
                    
                    ScrollView {
                        LazyVGrid(columns: layout) {
                            if viewModel.customCheck("custom") {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(viewModel.categoryCheck("custom") ? .green : Color(red: 251/255, green: 129/255, blue: 28/255))
                                    
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(lineWidth: 3)
                                    
                                    Text("Custom")
                                        .font(.title3)
                                        .foregroundColor(.black)
                                }
                                .frame(width: 100, height: 75)
                                .onTapGesture {
                                    viewModel.categoryTapped("custom")
                                }
                            }
                            
                            ForEach(Categories.allCases, id:\.self) { category in
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(viewModel.categoryCheck(category.rawValue) ? .green : Color(red: 251/255, green: 129/255, blue: 28/255))
                                        
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(lineWidth: 3)
                                        
                                        Text("\(category.rawValue.capitalized)")
                                            .font(.title3)
                                            .foregroundColor(.black)
                                    }
                                    .frame(width: 100, height: 75)
                                    .onTapGesture {
                                        viewModel.categoryTapped(category.rawValue)
                                    }
                            }
                        }.padding(.top)
                }
                NavigationLink {
                    GameView(viewModel: .init(teamName: viewModel.teamName, timeLimit: viewModel.timeLimit, questionLimit: viewModel.questionLimit), categories: viewModel.categorySet)
                } label: {
                    ZStack{
                        if !viewModel.buttonDisabled(){
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(red: 18/255, green: 52/255, blue: 80/255))
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lineWidth: 2)
                                .fill(.black)
                            Text("Play")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                        }
                    }.frame(width: UIScreen.screenWidth * 0.25, height: UIScreen.screenHeight * 0.05)
                }.disabled(viewModel.buttonDisabled())
                
                HStack{
                    Text("Time Limit:")
                    Picker(
                        selection: $viewModel.timeLimit,
                        label: HStack{
                            Text("Time Limit:")
                        },
                        content:{
                            Text("30 seconds").tag(30)
                            Text("60 seconds").tag(60)
                            Text("120 seconds").tag(120)
                            Text("240 seconds").tag(240)
                        }
                    ).pickerStyle(MenuPickerStyle())
                }.font(.headline)
            }
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
