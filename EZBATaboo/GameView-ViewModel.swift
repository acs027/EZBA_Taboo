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
        @Published var gameEnded = false
        @Published var gamePaused = false
        
        @Published var timeLimit : Int = 10
        @Published var currentTime : Int = 10
        
        @Published var gameTaboo = [TabooWord]()
        @Published var correctTaboo = [TabooWord]()
        @Published var incorrectTaboo = [TabooWord]()
        @Published var passedTaboo = [TabooWord]()
        
        @Published var teamScore = 0
        @Published var teamName : String
        @Published var passCount = 0
        
        @Published var questionLimit : Int = 10
        @Published var answeredQuestions = 0
        
        init(teamName: String, timeLimit: Int, questionLimit: Int) {
            self.teamName = teamName
            self.timeLimit = timeLimit
            self.currentTime = timeLimit
            self.questionLimit = questionLimit
        }
        
        func passCard() {
            if passCount < 3 && !gameTaboo.isEmpty{
                resetTimer()
                passCount += 1
                let card = gameTaboo.removeLast()
                passedTaboo.append(card)
            }
        }
        
        func correctAnswer() {
            if !gameTaboo.isEmpty {
                resetTimer()
                gameTaboo.removeLast()
                teamScore += 1
                answeredQuestions += 1
                if answeredQuestions == questionLimit {
                     gameEnded = true
                 }
            }
        }
        
        func wrongAnswer() {
            if !gameTaboo.isEmpty {
                resetTimer()
                gameTaboo.removeLast()
                answeredQuestions += 1
                if answeredQuestions == questionLimit {
                     gameEnded = true
                 }
            }
        }
        
        func startTimer() {
            currentTime = timeLimit
                Timer.scheduledTimer(withTimeInterval: 1, repeats: !gameEnded) { _ in
                    self.updateTimer()
                }
        }
        
        func updateTimer() {
            if !gamePaused {
                if currentTime > 0 {
                    currentTime -= 1
                } else {
                    wrongAnswer()
                }
            }
        }
        
        func resetTimer() {
            currentTime = timeLimit
            gamePaused = false
        }
        
        func loadGame() {
            for _ in 0...(questionLimit + 2) {
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
