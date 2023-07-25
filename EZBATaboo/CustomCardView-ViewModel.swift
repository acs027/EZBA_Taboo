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
        
        func writeData(_ newWord: TabooWord, _ fileName: String) {
            guard let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                print("Error getting documents directory URL.")
                return
            }
            
            var words : [TabooWord] = [newWord]
            
            let fileURL = documentsDirectoryURL.appendingPathComponent(fileName).appendingPathExtension("json")
            let encoder = JSONEncoder()
            
            if FileManager.default.fileExists(atPath: fileURL.path) {
                do {
                    let data = try Data(contentsOf: fileURL)
                    let decoder = JSONDecoder()
                    let oldData = try decoder.decode([TabooWord].self, from: data)
                    words += oldData
                    
                } catch {
                    print("Failed to read data: \(error.localizedDescription)")
                }
            }
            
            do {
                let encodedData = try encoder.encode(words)
                try encodedData.write(to: fileURL)
                print("Data saved to custom")
            } catch {
                print("Failed to save data: \(error.localizedDescription)")
            }
            
            resetCard()
        }

        
        func resetCard() {
            cardName = "Card Name"
            forbiddenWords = ["Forbidden Word 1", "Forbidden Word 2", "Forbidden Word 3", "Forbidden Word 4", "Forbidden Word 5"]
        }
    }
}
