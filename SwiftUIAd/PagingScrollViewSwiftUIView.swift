//
//  PagingScrollViewSwiftUIView.swift
//  SwiftUIAd
//
//  Created by Yun Ni on 2024-07-31.
//

import SwiftUI

struct PagingScrollViewSwiftUIView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {

                ForEach(0..<10) { index in
                    Rectangle()
                        .frame(width: 300, height: 300)
                        .overlay {
                            Text("\(index)").foregroundStyle(.white)
                        }
                        .frame(maxWidth: .infinity)
                }

            }
            .scrollBounceBehavior(.always)
        }
    }
}

#Preview {
    PagingScrollViewSwiftUIView()
}
