//
//  TypealiasSwiftUIView.swift
//  SwiftUIAd
//
//  Created by Yun Ni on 2024-07-25.
//

import SwiftUI

struct MovieModel {
    let title: String
    let director: String
    let count: Int
}

//struct TVModel {
//    let title: String
//    let director: String
//    let count: Int
//}

typealias TVModel = MovieModel

struct TypealiasSwiftUIView: View {

    @State var item: MovieModel = MovieModel(title: "HSDSD", director: "JOE", count: 1)

    @State var item1: TVModel = TVModel(title: "TV TITLE", director: "JOE", count: 1)

    var body: some View {
        VStack {
            Text(item1.title)
            Text(item1.director)
            Text("\(item.count)")
        }
    }
}

#Preview {
    TypealiasSwiftUIView()
}
