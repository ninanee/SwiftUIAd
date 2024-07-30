//
//  GeometryReaderSwiftUIView.swift
//  SwiftUIAd
//
//  Created by Yun Ni on 2024-07-23.
//

import SwiftUI

struct GeometryReaderSwiftUIView: View {

    func getPercentage(geo: GeometryProxy) -> Double {
        // get the center of the screen
        let maxDistance = UIScreen.main.bounds.width / 2

        // get mid x coordinate of the rectangle
        let currentX = geo.frame(in: .global).midX
        return (1 - (currentX / maxDistance))
    }


    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<20) { index in
                    GeometryReader(content: { geometry in
                        RoundedRectangle(cornerRadius: 20)
                            .rotation3DEffect(
                                Angle(degrees: getPercentage(geo: geometry) * 40),
                                axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                    })
                    .frame(width: 300, height: 250)
                    .padding()
                }
            }
        }
    }
}

#Preview {
    GeometryReaderSwiftUIView()
}
