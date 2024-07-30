//
//  weakSelfSwiftUIView.swift
//  SwiftUIAd
//
//  Created by Yun Ni on 2024-07-25.
//

import SwiftUI

struct WeakSelfSwiftUIView: View {
    var body: some View {
        NavigationView{
            NavigationLink("Navigate", destination: 
                            WeakSelfSecondScreen()
                .navigationTitle("Screen 1")
            )
            .navigationTitle("Title")
        }
    }
}

struct WeakSelfSecondScreen: View {

    @StateObject var vm = WeakSelfSecondScreenViewModel()

    var body: some View {
        Text("Second View")
            .font(.largeTitle)
            .foregroundStyle(.red)

        if let data = vm.data {
            Text(data)
        }
    }
}

class WeakSelfSecondScreenViewModel: ObservableObject {

    @Published var data: String? = nil

    init() {
        print("INITIALIZE NOW")
        getData()
    }

    deinit {
        print("DEINITIALIZE now")

    }

    func getData() {
        data = "NEW DATA"
    }
}

#Preview {
    WeakSelfSwiftUIView()
}
