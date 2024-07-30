//
//  HapticsSwiftUIView.swift
//  SwiftUIAd
//
//  Created by Yun Ni on 2024-07-23.
//

import SwiftUI

class HapticsManager {

    static let instance = HapticsManager()

    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }

    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let genertor = UIImpactFeedbackGenerator(style: style)
        genertor.impactOccurred()
    }
}
struct HapticsSwiftUIView: View {

//    private var tey: HapticsManager = HapticsManager()

    var body: some View {
        VStack(spacing: 20, content: {
            Button("success") {
                HapticsManager.instance.notification(type: .success)
            }

            Button("warning") {
                HapticsManager.instance.notification(type: .warning)
            }

            Button("error") {
                HapticsManager.instance.notification(type: .error)
            }

            Divider()

            Button("error") {
                HapticsManager.instance.impact(style: .soft)
            }

            Button("light") {
                HapticsManager.instance.impact(style: .light)
            }

            Button("heavy") {
                HapticsManager.instance.impact(style: .heavy)
            }

            Button("medium") {
                HapticsManager.instance.impact(style: .medium)
            }

            Button("rigid") {
                HapticsManager.instance.impact(style: .rigid)
            }
        })
    }
}

#Preview {
    HapticsSwiftUIView()
}
