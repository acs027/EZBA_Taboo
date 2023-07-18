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
        VStack {
            Text("Select one or more Categories")
            
            ZStack(alignment: .center) {
                Color.white
                    .ignoresSafeArea()
                
                ScrollView {
                    LazyVGrid(columns: layout) {
                        ForEach(Categories.allCases, id:\.self) { category in
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(viewModel.categoryCheck(category.rawValue) ? .green : .orange)
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 3)
                                
                                Text("\(category.rawValue)")
                                    .font(.title3)
                                    .foregroundColor(.black)
                            }
                            .frame(width: 100, height: 75)
                            .onTapGesture {
                                viewModel.categoryTapped(category.rawValue)
                            }
                        }
                    }
                }.padding(.horizontal)
            }
            
//            TextField("Team Name", text: $viewModel.teamName)
            
            NavigationLink {
                GameView(viewModel: .init(teamName: viewModel.teamName, timeLimit: viewModel.timeLimit, questionLimit: viewModel.questionLimit), categories: viewModel.categorySet)
            } label: {
                Text("Play")
            }.disabled(viewModel.categorySet.isEmpty)
            
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
            }
            
//            HStack{
//                Text("Number of Questions:")
//                Picker("Number of Questions: ", selection: $viewModel.questionLimit){
//                    ForEach(numberofQs, id: \.self) {
//                        Text("\($0)")
//                    }
//                }
//            }
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
