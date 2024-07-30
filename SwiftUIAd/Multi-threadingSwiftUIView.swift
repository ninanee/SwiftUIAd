//
//  Multi-threadingSwiftUIView.swift
//  SwiftUIAd
//
//  Created by Yun Ni on 2024-07-25.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject {

    @Published var dataArray: [String] = []

    func fetchData() {

        DispatchQueue.global().async {
            let newdata = self.downloadData()

            print("Check 1: \(Thread.isMainThread)")
            print("Check 1: \(Thread.current)")


            DispatchQueue.main.async {
                self.dataArray = newdata

                print("Check 1: \(Thread.isMainThread)")
                print("Check 1: \(Thread.current)")
            }

        }

    }

    private func downloadData() -> [String] {
        var data: [String] = []

        for x in 0..<100 {
            data.append("\(x)")
            print(data)
        }
        return data
    }

}
struct Multi_threadingSwiftUIView: View {

    @StateObject var vm = BackgroundThreadViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("LOAD DATA")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }

                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundStyle(.red)
                }
            }
        }
    }
}

#Preview {
    Multi_threadingSwiftUIView()
}
