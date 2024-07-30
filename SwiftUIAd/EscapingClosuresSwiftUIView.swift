//
//  EscapingClosuresSwiftUIView.swift
//  SwiftUIAd
//
//  Created by Yun Ni on 2024-07-25.
//

import SwiftUI

class EscapingViewModel: ObservableObject {

    @Published var text: String = "Hello"

    func getData() {
//        let data = downloadData2()
//        text = data

        downloadData3 {[weak self] returnedData in
            self?.text = returnedData
        }
    }

    func downloadData() -> String {
        return "New DATA"
    }

    // only when we using completionHandler, we can add -> void, return nothing
    func downloadData2(completionHandler: (_ data: String) -> Void) {

        completionHandler("New DATA")
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {

    }

    // this is return void : -> ()
    func downloadData3(completionHandler: @escaping (_ data: String) -> ()) {

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completionHandler("New DATA")
        }
    }

    func downloadData4(completionHandler: @escaping (DownloadResult) -> ()) {

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(data: "NEWWW DATAAA")
            completionHandler(result)
        }

    }
}

struct DownloadResult {
    let data: String
}

struct EscapingClosuresSwiftUIView: View {

    @StateObject var vm = EscapingViewModel()

    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundStyle(.blue)
            .onTapGesture {
                vm.getData()
            }
    }
}

#Preview {
    EscapingClosuresSwiftUIView()
}
