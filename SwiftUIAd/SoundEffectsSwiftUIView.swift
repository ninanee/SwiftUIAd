//
//  SoundEffectsSwiftUIView.swift
//  SwiftUIAd
//
//  Created by Yun Ni on 2024-07-23.
//

import SwiftUI
import AVKit

class SoundManager {

    //THIS IS SINGLETON
    static let instance = SoundManager()

    var player: AVAudioPlayer?

    func playSound() {
        guard let url = URL(string: "https://freesoundslibrary.com") else {return}

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("ERROR PLAYING SOUND. \(error.localizedDescription)")
        }

    }
}

struct SoundEffectsSwiftUIView: View {

    var soundManager = SoundManager()

    var body: some View {
        VStack(spacing: 40) {
            Button("Play Sound 1") {

            }

            Button("Play Sound 2") {

            }
        }
    }
}

#Preview {
    SoundEffectsSwiftUIView()
}
