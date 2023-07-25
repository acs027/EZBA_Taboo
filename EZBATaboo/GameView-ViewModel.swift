//
//  GameView-ViewModel.swift
//  EZBATaboo
//
//  Created by ali cihan on 1.06.2023.
//

import Foundation
import SwiftUI
import CoreHaptics
import AudioToolbox

extension GameView {
    @MainActor class ViewModel: ObservableObject {
        @Published var datas = ReadData()
        @Published var engine: CHHapticEngine?
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
        
        @Published var offset : CGFloat = 0
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
                passCount += 1
                hapticFeedback(time: 1)
                let card = gameTaboo.removeLast()
                passedTaboo.append(card)
            }
        }
        
        func correctAnswer() {
            if !gameTaboo.isEmpty {
                gameTaboo.removeLast()
                teamScore += 1
                answeredQuestions += 1
                hapticFeedback(time: 1)
                if answeredQuestions == questionLimit {
                     gameEnded = true
                 }
            }
        }
            
        func prepareHaptics() {
            guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
            
            do {
                engine = try CHHapticEngine()
                try engine?.start()
            } catch {
                print("There was an error creatinghg the engine: \(error.localizedDescription)")
            }
        }
        
        func hapticFeedback(time: Float){
            guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
            
            var events = [CHHapticEvent]()
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.8)
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
            events.append(event)
            
            do {
                let pattern = try CHHapticPattern(events: events, parameters: [])
                let player = try engine?.makePlayer(with: pattern)
                try player?.start(atTime: 0)
            } catch {
                print("Failed to play pattern \(error.localizedDescription)")
            }
        }
        
        func wrongAnswer() {
            if !gameTaboo.isEmpty {
                gameTaboo.removeLast()
                answeredQuestions += 1
                AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {   }
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
            if !gamePaused && !gameEnded && checkAppState(){
                if currentTime > 0 {
                    if currentTime < 11 {
                        hapticFeedback(time: Float(currentTime))
                    }
                    currentTime -= 1
                    print(currentTime)
                } else {
                    wrongAnswer()
                    gameEnded = true
                }
            }
        }
        
        func resetTimer() {
            currentTime = timeLimit
            gamePaused = false
        }
        
        func pauseGame() {
            gamePaused.toggle()
            withAnimation(.easeInOut(duration: 0.5)){
                if gamePaused {
                    offset = UIScreen.main.bounds.height * 0.1
                } else {
                    offset = 0
                }
            }
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
                if category == "custom" {
                    datas.loadCustom()
                    print("custom dahil")
                } else {
                    datas.loadData(category)
                }
            }
        }
        
        func checkAppState() -> Bool {
            let appState = UIApplication.shared.applicationState

            switch appState {
            case .active:
                return true
            case .inactive:
                return false
            case .background:
                return false
            @unknown default:
                return false
            }
        }
    }
}
