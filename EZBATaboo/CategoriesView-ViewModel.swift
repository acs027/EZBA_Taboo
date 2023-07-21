//
//  CategoriesView-ViewModel.swift
//  EZBATaboo
//
//  Created by ali cihan on 31.05.2023.
//

import Foundation
import SwiftUI

extension CategoriesView {
    class ViewModel: ObservableObject {
        @Published var categorySet = Set<String>()
        @Published var teamName = "Team Name"
        @Published var timeLimit = 60
        @Published var questionLimit = 10
        
        func opacityCalculator(geometry: GeometryProxy) -> CGFloat {
            if geometry.frame(in: .global).midX < 100 {
                return geometry.frame(in: .global).midX * 0.01
            } else if geometry.frame(in: .global).midX > UIScreen.screenWidth - 100 {
                return (UIScreen.screenWidth - geometry.frame(in: .global).midX) * 0.01
            }
            return 1.0
        }
        
        func categoryTapped(_ category: String) {
            if categoryCheck(category) {
                categorySet.remove(category)
            } else {
                categorySet.insert(category)
            }
        }
        
        func categoryCheck(_ category: String) -> Bool {
            if categorySet.contains(category) { return true }
            return false
        }
        
        func customCheck(_ category: String) -> Bool {
            if category == "custom" {
                return !isJSONFileEmpty("custom")
            }
            return true
        }
        
        func isJSONFileEmpty(_ fileName: String) -> Bool {
            let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json")
            do {
                // Read the contents of the file into Data
                let jsonData = try Data(contentsOf: fileURL!)
                
                // Parse the JSON data into a Swift data structure
                let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                
                // Check if the parsed JSON data structure is empty
                if let jsonArray = jsonObject as? [Any], jsonArray.isEmpty {
                    return true
                } else if let jsonDictionary = jsonObject as? [String: Any], jsonDictionary.isEmpty {
                    return true
                }
                
                // If the JSON data structure is not empty, return false
                return false
            } catch {
                // Catch any errors that occur during reading or parsing
                print("Error while checking JSON file: \(error)")
                return true
            }
        }
        
        func buttonDisabled() -> Bool {
            if categorySet.contains("custom") && categorySet.count > 1 {
                return false
            } else if !categorySet.contains("custom") && !categorySet.isEmpty{
                return false
            }
            return true
        }
        
    }
    enum Categories: String, CaseIterable, Equatable {
        case custom, animals, cars, city_country, food, literature, people, sports, things, tv, web
    }
}

extension UIScreen {
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenWidth = UIScreen.main.bounds.size.width
}
