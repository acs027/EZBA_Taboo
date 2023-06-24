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
        
    }
    enum Categories: String, CaseIterable, Equatable {
        case animals, cars, city_country, food, literature, people, sports, things, tv, web
    }
}

extension UIScreen {
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenWidth = UIScreen.main.bounds.size.width
}
