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
        GADInterstitialAd.load(withAdUnitID:"ca-app-pub-3940256099942544/4411468910",
                               request: request,
                               completionHandler: { [self] ad, error in
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
            let root = UIApplication.shared.windows.first?.rootViewController
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
