//
//  VoiceOverSwiftUIView.swift
//  SwiftUIAd
//
//  Created by Yun Ni on 2024-07-31.
//

import SwiftUI

struct VoiceOverSwiftUIView: View {

    @State private var isActive: Bool = false

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Toggle("Volume", isOn: $isActive)

                    HStack {
                        Text("Volumn")
                        Spacer()

                        Text(isActive ? "ON" : "OFF")
                    }
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        isActive.toggle()
                    }
                    .accessibilityElement(children: .combine)
                    .accessibilityAddTraits(.isButton)
                    .accessibilityHint("Double tap to togglesetting.")
                    .accessibilityAction {
                        isActive.toggle()
                    }

                } header: {
                    Text("PERFERENCE")
                }
                Section {
                    Button {

                    } label: {
                        Image(systemName: "heart.fill")
                    }

                }
            }
        }
    }
}

#Preview {
    VoiceOverSwiftUIView()
}
