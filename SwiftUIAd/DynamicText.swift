//
//  DynamicText.swift
//  SwiftUIAd
//
//  Created by Yun Ni on 2024-07-31.
//

import SwiftUI

struct DynamicText: View {
    var body: some View {
        NavigationStack {
            List{
                ForEach(0..<10) {_ in 
                    VStack(alignment: .leading, spacing: 7, content: {
                        HStack(content: {
                            Image(systemName: "heart.fill")
                            Text("Welcome to my app")
                        })
                        .font(.title)

                        Text("This is some longer text that expands to multiple lines.")
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(3)
                            .minimumScaleFactor(0.5)

                    })
                    .frame(height: 100)
                    .background(.red)
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Hello, World")
        }

    }
}

#Preview {
    DynamicText()
}
