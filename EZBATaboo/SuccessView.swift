//
//  SuccessView.swift
//  EZBATaboo
//
//  Created by Furkan Eken on 26.07.2023.
//

import SwiftUI

struct SuccessView: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 5).foregroundColor(.white)
            RoundedRectangle(cornerRadius: 10).foregroundColor(.black)
            VStack{
                Text("Card Added!")
                    .foregroundColor(.white)
                    .padding(.top, 25)
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .foregroundColor(.white)
                    .scaledToFit()
                    .padding(10)
                    .padding(.bottom)
            }
        }.frame(width: UIScreen.screenWidth * 0.3, height: UIScreen.screenHeight * 0.15)
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView()
    }
}
