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
        
        init(teamScore: Int, teamName: String) {
            self.teamScore = teamScore
            self.teamName = teamName
        }
    }
}
