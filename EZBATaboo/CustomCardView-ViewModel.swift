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
        
        func WriteData(_ data: [TabooWord], _ fileName: String) {
            let jsonEncoder = JSONEncoder()
            let jsonData = try? jsonEncoder.encode(data)

            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json")
                else {
                print("Not found")
                return
            }
            do {
                try jsonData!.write(to: fileURL)
                print("Data saved to \(fileName)")
            } catch {
                print("Failed to save data")
            }
        }
        
        func resetCard() {
            cardName = "Card Name"
            forbiddenWords = ["Forbidden Word 1", "Forbidden Word 2", "Forbidden Word 3", "Forbidden Word 4", "Forbidden Word 5"]
        }
    }
}
