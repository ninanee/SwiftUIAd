//
//  ArraysSwiftUIView.swift
//  SwiftUIAd
//
//  Created by Yun Ni on 2024-07-24.
//

import SwiftUI

struct UserModel: Identifiable {

    let id = UUID().uuidString
    let name: String
    let point: Int
    let isVerified: Bool

}

class ArrayModificationViewModel: ObservableObject {

    @Published var dataArray: [UserModel] = []

    @Published var filteredArray: [UserModel] = []

    @Published var mappedArray: [String] = []

    init() {
        getUser()
        updateFilteredArray()
    }

    func updateFilteredArray() {
        // Sort
        // Filter
        // Map


        // 1. Sort
//        filteredArray = dataArray.sorted(by: { user1, user2 in
//            return user1.point > user2.point
//        })

        //another way
//        filteredArray = dataArray.sorted(by: {$0.point > $1.point})

        // 2 Filter
//        filteredArray = dataArray.filter({ user in
////            return user.point > 10
//            return user.name.contains("i")
//        })

        // 3. MAP!!!! can transfer a type from one to another
        mappedArray = dataArray.map({ user in
            return user.name
        })

        // if there is some optional in the array, we can use compactMap()


    }

    func getUser() {

        let user1 = UserModel(name: "Nick", point: 5, isVerified: true)
        let user2 = UserModel(name: "Chris", point: 0, isVerified: false)
        let user3 = UserModel(name: "Joe", point: 25, isVerified: true)
        let user4 = UserModel(name: "Mary", point: 35, isVerified: true)
        let user5 = UserModel(name: "King", point: 45, isVerified: false)
        let user6 = UserModel(name: "Queen", point: 54, isVerified: true)
        let user7 = UserModel(name: "Harry", point: 23, isVerified: true)
        let user8 = UserModel(name: "Emma", point: 1, isVerified: true)
        let user9 = UserModel(name: "Lisa", point: 33, isVerified: false)
        let user10 = UserModel(name: "Noah", point: 2, isVerified: true)
        let user11 = UserModel(name: "Lily", point: 39, isVerified: false)

        self.dataArray.append(contentsOf: [
            user1, user2, user3, user4, user5, user6, user7, user8, user9, user10, user11
        ])
    }

}

struct ArraysSwiftUIView: View {

    @StateObject var vm = ArrayModificationViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
//                ForEach(vm.filteredArray) { user in
//                    VStack {
//                        Text(user.name)
//                        HStack {
//                            Text("Points: \(user.point)")
//                            Spacer()
//                            if user.isVerified {
//                                Image(systemName: "flame.fill")
//                            }
//                        }
//                    }
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.orange.cornerRadius(10))
//                    .padding(.horizontal)
//                }

                ForEach(vm.mappedArray, id: \.self) { item in
                    Text(item)
                }
            }
        }
    }
}

#Preview {
    ArraysSwiftUIView()
}
