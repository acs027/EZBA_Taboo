//
//  CustomCardView-ViewModel.swift
//  EZBATaboo
//
//  Created by Furkan Eken on 18.07.2023.
//

import Foundation
import SwiftUI

extension CustomCardView {
    class ViewModel: ObservableObject {
        @Published var cardName = "Card Name"
        @Published var forbiddenWords = ["Forbidden Word 1", "Forbidden Word 2", "Forbidden Word 3", "Forbidden Word 4", "Forbidden Word 5"]
        
        func resetCard() {
            cardName = "Card Name"
            forbiddenWords = ["Forbidden Word 1", "Forbidden Word 2", "Forbidden Word 3", "Forbidden Word 4", "Forbidden Word 5"]
        }
    }
}
