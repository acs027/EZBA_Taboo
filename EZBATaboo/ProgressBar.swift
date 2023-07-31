//
//  TimeCircleView.swift
//  EZBATaboo
//
//  Created by Furkan Eken on 29.07.2023.
//

import SwiftUI

struct ProgressBar: View{
    @Binding var timeLimit : Int
    @Binding var currentTime : Int
    var color: Color = Color.black
    
    var body: some View{
        ZStack{
            Circle()
                .stroke(lineWidth: 2)
                .opacity(0.5)
                .foregroundColor(Color.gray)
            
            Circle()
                .trim(from: 0, to: CGFloat(Float(currentTime) / Float(timeLimit)))
                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .foregroundColor(color)
                .opacity(0.8)
                .rotationEffect(Angle(degrees: 270))
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
        }.frame(width: 40, height: 40)
    }
}
