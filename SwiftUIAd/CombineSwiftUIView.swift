//
//  CombineSwiftUIView.swift
//  SwiftUIAd
//
//  Created by Yun Ni on 2024-07-25.
//

import SwiftUI
import Combine

struct PostModel2: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithCombineViewModel: ObservableObject {

    @Published var posts: [PostModel2] = []

    var cancellables = Set<AnyCancellable>()

    init() {
        getPost()
    }

    func getPost(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }

        // COMBINE DISCUESSION

        // 1. sign up for monthly subscription for package to be delivered
        // 2. the company would make the package behind the scene
        // 3. receieve the package at your front door
        // 4. make sure the box isnt damaged
        // 5. open and make sure the item is correct
        // 6. use the item!!
        // 7. cancallable at any time

        // 1. create a publisher
        // 2. subscribe the publisher on background thread
        // 3. receive on main thread
        // 4. try map -> to check the quality of the products
        // 5. decode data into PostModel
        // 6. sink put the item into our app
        // 7. store (cancal subscribtion at any time)

        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handelOutput)
            .decode(type: [PostModel2].self, decoder: JSONDecoder())
            .sink { completion in
//                switch completion {
//                case .finished:
//                    print("finshed")
//                case .failure(let error):
//                    print("There was an errror. \(error.localizedDescription)")
//                }
                print("COMPLETION: \(completion)")
            } receiveValue: { [weak self] (returnposts) in
                self?.posts = returnposts
            }
            .store(in: &cancellables)

    }

    func handelOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            print("error downloading data")
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}

struct CombineSwiftUIView: View {

    @StateObject var vm = DownloadWithCombineViewModel()

    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)            }
        }

    }
}

#Preview {
    CombineSwiftUIView()
}
