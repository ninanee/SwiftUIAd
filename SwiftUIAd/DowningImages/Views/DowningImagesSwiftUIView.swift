//
//  DowningImagesSwiftUIView.swift
//  SwiftUIAd
//
//  Created by Yun Ni on 2024-07-30.
//

import SwiftUI

//cacheable
//Background thread
//weak self
//combine
//publisher and subscribers
// filemanager
// Nscache

struct DowningImagesSwiftUIView: View {

    @StateObject var vm =  DownloadingImagesViewModel()

    var body: some View {

        NavigationView(content: {
            List {
                ForEach(vm.dataArray) { model in
                    DownloadingImagesRow(model: model)
                }
            }
            .navigationTitle("Downloading images")
        })
    }
}

#Preview {
    DowningImagesSwiftUIView()
}
