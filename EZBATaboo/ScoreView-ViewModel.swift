//
//  ScoreView-ViewModel.swift
//  EZBATaboo
//
//  Created by Furkan Eken on 9.07.2023.
//

import Foundation
import SwiftUI

extension ScoreView {
    @MainActor class ViewModel: ObservableObject {
        @Published var teamScore = 0
        @Published var teamName = "Default"
        @Published var extraTime = 0
        
        init(teamScore: Int, teamName: String, extraTime: Int) {
            self.teamScore = teamScore
            self.teamName = teamName
            self.extraTime = extraTime
        }
    }
}
