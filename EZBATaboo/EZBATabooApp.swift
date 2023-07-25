//
//  EZBATabooApp.swift
//  EZBATaboo
//
//  Created by ali cihan on 29.05.2023.
//

import SwiftUI
import GoogleMobileAds
import UIKit

@main
struct EZBATabooApp: App {
    init() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        UIApplication.shared.isIdleTimerDisabled = true
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
