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
                        Text("Categories")
                    }
                    .frame(width: UIScreen.screenWidth/3, height: UIScreen.screenHeight/3)
                }
                
                Button {
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.orange)
                        Text("Exit")
                    }
                    .frame(width: UIScreen.screenWidth/3, height: UIScreen.screenHeight/3)
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
