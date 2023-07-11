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
    
    var body: some View {
        VStack {
            ZStack(alignment: .center) {
                Color.black
                    .ignoresSafeArea()
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(Categories.allCases, id:\.self) { category in
                            ZStack {
                                GeometryReader { geometry in
                                    Group {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(viewModel.categoryCheck(category.rawValue) ? .green : .gray)
                                        
                                        Text("\(category.rawValue)")
                                            .font(.largeTitle)
                                    }
                                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                                    .opacity(viewModel.opacityCalculator(geometry: geometry))
                                }
                            }
                            .frame(width: 200, height: 200)
                            .onTapGesture {
                                viewModel.categoryTapped(category.rawValue)
                            }
                        }
                    }
                }
            }
            TextField("Team Name", text: $viewModel.teamName)
            
            NavigationLink {
                GameView(viewModel: .init(teamName: viewModel.teamName), categories: viewModel.categorySet)
            } label: {
                Text("Play")
            }.disabled(viewModel.categorySet.isEmpty)
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
