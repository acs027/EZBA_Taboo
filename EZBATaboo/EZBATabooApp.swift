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
    @State var showLaunchScreen = true
    init() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        UIApplication.shared.isIdleTimerDisabled = true
    }
    var body: some Scene {
        WindowGroup {
            ZStack{
                ContentView()
                if showLaunchScreen {
                    LaunchScreenView()
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 4){
                    showLaunchScreen = false
                }
            }
        }
    }
}
