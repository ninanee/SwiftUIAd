//
//  SubscribersSwiftUIView.swift
//  SwiftUIAd
//
//  Created by Yun Ni on 2024-07-29.
//
// Always trying to use SINK in publish && subscribe


import SwiftUI
import Combine

class SubscribersViewModel: ObservableObject {

    @Published var count: Int = 0
//    var timer: AnyCancellable?

    // if we have a bruch of obj to cancel
    var cancellables = Set<AnyCancellable>()

    @Published var textFieldText: String = ""
    @Published var textIsValid: Bool = false

    init() {
        setUpTimer()
        addTextFieldSubscriber()
    }

    func addTextFieldSubscriber() {
        $textFieldText
        // after 0.5s, its gonna check
//            .debounce(for: .second(0.5), scheduler: DispatchQueue.main)
            .map { (text) -> Bool in
                if text.count > 3 {
                    return true
                }
                return false
            }
//            .assign(to: \.textIsValid, on: self)
            .sink(receiveValue: {[weak self] (isvaild) in
                self!.textIsValid = isvaild
            })
            .store(in: &cancellables)
    }

    func setUpTimer() {
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink {[weak self]_ in
                // check if the self is valid. this is important
                guard let self = self else{return}

                self.count += 1

                if self.count >= 10 {
                    for item in cancellables {
                        item.cancel()
                    }
                }
            }
            .store(in: &cancellables)
    }
}

struct SubscribersSwiftUIView: View {

    @StateObject var vm = SubscribersViewModel()

    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.largeTitle)

            Text("\(vm.textIsValid.description)")
            TextField("Type something here...", text: $vm.textFieldText)
                .padding(.leading)
                .frame(height: 55)
                .font(.headline)
                .background(Color.gray)
                .cornerRadius(10)
                .overlay {
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                            .opacity(
//                                vm.textIsValid.count < 1 ?
                                vm.textIsValid ? 0.0 : 1.0)

                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .opacity(vm.textIsValid ? 1.0 : 0.0)
                    }
                    .font(.title)
                    .padding(.trailing)
                }
        }
    }
}

#Preview {
    SubscribersSwiftUIView()
}
