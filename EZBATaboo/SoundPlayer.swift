//
//  SoundPlayer.swift
//  EZBATaboo
//
//  Created by Furkan Eken on 29.07.2023.
//

import Foundation
import AVFoundation

class SoundPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {
    var audioPlayer: AVAudioPlayer?

    func playSound(soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {
            print("Sound file not found.")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch let error {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}

