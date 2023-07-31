//
//  LauncScreenView.swift
//  acslaunchscreen
//
//  Created by ali cihan on 30.07.2023.
//

import SwiftUI

struct LaunchScreenView: View {
    @State var anim_param = 0.0
    var body: some View {
        ZStack {
            background
            foreground
                .opacity(anim_param/100)
            
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                withAnimation(.linear(duration: 2)) {
                    anim_param = 100.0
                }
            }
            
        }
    }
        
    
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}

private extension LaunchScreenView {
    var background: some View {
        Image("wordsmith2")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
    
    var foreground: some View {
        Image("wordsmith")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()

    }
}
