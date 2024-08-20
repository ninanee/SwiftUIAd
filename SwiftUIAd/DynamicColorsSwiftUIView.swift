//
//  DynamicColorsSwiftUIView.swift
//  SwiftUIAd
//
//  Created by Yun Ni on 2024-07-31.
//

import SwiftUI

struct DynamicColorsSwiftUIView: View {
    var body: some View {
        VStack{
            Button {

            } label: {
                Text("Button 1")
            }
            .foregroundColor(.primary)
            .buttonStyle(BorderedProminentButtonStyle())

            Button {

            } label: {
                Text("Button 2")
            }
            .foregroundColor(.primary)
            .buttonStyle(BorderedProminentButtonStyle())
            .tint(.orange)

            Button {

            } label: {
                Text("Button 3")
            }
            .foregroundColor(.primary)
            .buttonStyle(BorderedProminentButtonStyle())
            .tint(.green)

            Button {

            } label: {
                Text("Button 4")
            }
            .foregroundColor(.primary)
            .buttonStyle(BorderedProminentButtonStyle())
            .tint(.purple)
        }
        .font(.largeTitle)

    }
}

#Preview {
    DynamicColorsSwiftUIView()
}
