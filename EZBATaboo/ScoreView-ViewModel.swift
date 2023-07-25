//
//  ScoreView-ViewModel.swift
//  EZBATaboo
//
//  Created by Furkan Eken on 9.07.2023.
//

import Foundation
import SwiftUI
import GoogleMobileAds

extension ScoreView {
    @MainActor class ViewModel: ObservableObject {
        @Published var teamScore = 0
        @Published var teamName = "Default"
        @Published var adReady = false
        @Published var fullScreenAd: Interstitial?
        
        init(teamScore: Int, teamName: String) {
            self.teamScore = teamScore
            self.teamName = teamName
            self.adReady = false
            fullScreenAd = Interstitial()
        }
        
        func offsetSwitch(){
            adReady = true
            print("ad ready")
        }
        
        func callAd() {
            self.fullScreenAd?.showAd()
        }
    }
}
