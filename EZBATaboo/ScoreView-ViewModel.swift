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
        
        init(teamScore: Int) {
            self.teamScore = teamScore
        }
    }
}
