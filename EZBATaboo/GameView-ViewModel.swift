//
//  GameView-ViewModel.swift
//  EZBATaboo
//
//  Created by ali cihan on 1.06.2023.
//

import Foundation
import SwiftUI

extension GameView {
    @MainActor class ViewModel: ObservableObject {
        @Published var datas = ReadData()
        @Published var gameStarted = false
        
        @Published var gameTaboo = [TabooWord]()
        @Published var correctTaboo = [TabooWord]()
        @Published var incorrectTaboo = [TabooWord]()
        @Published var passedTaboo = [TabooWord]()
        
        func nextCard() {
            let card = gameTaboo.removeLast()
            passedTaboo.append(card)
        }
        
        func loadGame() {
            for _ in 0...9 {
                let randomWord = datas.words.randomElement()
                gameTaboo.append(randomWord!)
            }
        }
        
        func loadData(categories: Set<String>) {
            objectWillChange.send()
            for category in categories {
                datas.loadData(category)
            }
        }
    }
}
