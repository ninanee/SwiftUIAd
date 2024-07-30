//
//  HashableProtocolSwiftUIView.swift
//  SwiftUIAd
//
//  Created by Yun Ni on 2024-07-24.
//

import SwiftUI

struct MyCustomModel: Hashable {

    let title: String

    // this is the hash function that we can has the value
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }

}

struct HashableProtocolSwiftUIView: View {

    let data: [MyCustomModel] = [
        MyCustomModel(title: "ONE"),
        MyCustomModel(title: "TWO"),
        MyCustomModel(title: "THREE"),
        MyCustomModel(title: "FOUR"),
        MyCustomModel(title: "FIVE")]

    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                ForEach(data, id: \.self) { item in
                    Text(item.hashValue.description)
                        .font(.headline)
                    }
            }
        }

    }
}

#Preview {
    HashableProtocolSwiftUIView()
}
