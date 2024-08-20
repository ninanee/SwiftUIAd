//
//  AccessibilityVoiceOverSwiftUIView.swift
//  SwiftUIAd
//
//  Created by Yun Ni on 2024-08-12.
//

import SwiftUI

struct AccessibilityVoiceOverSwiftUIView: View {

    @State private var isActive: Bool = false

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Toggle("Volume", isOn: $isActive)

                    HStack {
                        Text("Volume")
                        Spacer()

                        Text(isActive ? "ON" : "OFF")
                    }
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        isActive.toggle()
                    }
                } header: {
                    Text("PREFERENCE")
                }

                Section {
                    Button("Favorites") {

                    }

                    Button {

                    } label: {
                        Image(systemName: "heart.fill")
                    }
                    .accessibilityLabel("Favourite")

                    Text("Favorites")
                        .onTapGesture {

                        }
                } header: {
                    Text("APPLICATION")
                }

                VStack {
                    Text("CONTENT")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.secondary)
                        .font(.caption)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {

                            ForEach(0..<10) { x in
                                VStack {
                                    Image("steve")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(10)

                                    Text("Item \(x + 1)")
                                }
                                .onTapGesture {


                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    AccessibilityVoiceOverSwiftUIView()
}
