//
//  MaskSwiftUIView.swift
//  SwiftUIAd
//
//  Created by Yun Ni on 2024-07-23.
//

import SwiftUI

struct MaskSwiftUIView: View {

    @State var rating: Int = 0

    var body: some View {
        ZStack {
            startsView
                .overlay(
                    overlayView
                        .mask(startsView)
                )
        }
    }

    private var overlayView: some View {
        GeometryReader { geomotry in
            ZStack(alignment: .leading, content: {
                Rectangle()
                    .foregroundColor(.yellow)
                    .frame(width: CGFloat(rating) / 5 * geomotry.size.width)
            }
        )}
        // users cant type on the overlayer
        .allowsHitTesting(false)
    }

    private var startsView: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(Color.gray)
                    .onTapGesture {
                        withAnimation(.easeOut) {
                            rating = index
                        }

                    }

            }
        }
    }
}

#Preview {
    MaskSwiftUIView()
}
