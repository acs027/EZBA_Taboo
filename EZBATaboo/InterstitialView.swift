//
//  AdView.swift
//  EZBATaboo
//
//  Created by Furkan Eken on 20.07.2023.
//

import GoogleMobileAds
import SwiftUI
import UIKit

final class Interstitial:NSObject, GADFullScreenContentDelegate {
    var interstitial:GADInterstitialAd?
    
    override init() {
        super.init()
        self.loadInterstitial()
    }
    
    func loadInterstitial(){
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID:"xxx",
                               request: request,
                               completionHandler: { [weak self] ad, error in
            guard let self = self else { return }
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
            }
            interstitial = ad
            interstitial?.fullScreenContentDelegate = self
        })
    }
    
    func showAd(){
        if self.interstitial != nil {
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            let window = windowScene?.windows.first
            let root = window?.rootViewController
            self.interstitial?.present(fromRootViewController: root!)
        }
        else{
            print("Not Ready")
        }
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
        self.loadInterstitial()
    }
    
}
