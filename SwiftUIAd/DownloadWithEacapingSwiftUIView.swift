//
//  DownloadWithEacapingSwiftUIView.swift
//  SwiftUIAd
//
//  Created by Yun Ni on 2024-07-25.
//

import SwiftUI

struct PostModel: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithEacapingViewModel: ObservableObject {

    @Published var posts: [PostModel] = []

    init() {
        getPosts()
    }

    func getPosts() {

        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        downloadData(fromURL: url) { returneddata in
            if let data = returneddata{
                guard let newPost = try? JSONDecoder().decode([PostModel].self, from: data) else{return}

                DispatchQueue.main.async { [weak self] in
                    self?.posts = newPost
                }
            } else {
                print("NO DATA RETURNED")
            }
        }
    }



    //            guard let data = data else {
    //                print("no data")
    //                return
    //            }
    //
    //            guard error == nil else {
    //                print("with error")
    //                return
    //            }
    //
    //            guard let response = response as? HTTPURLResponse else {
    //                print("Invalid response")
    //                return
    //            }
    //
    //            guard response.statusCode >= 200 && response.statusCode < 300 else {
    //                print("statusCode shoud be 2xx, but is \(response.statusCode)")
    //                return
    //            }
    //            print("SUCCESSFULLY DOWNLOADED DATA")
    //            print(data)

    //            let jsonString = String(data: data, encoding: .utf8)
    //            print(jsonString)



    func downloadData(fromURL url: URL, completionHandler: @escaping (_ data: Data?) -> ()) {

        URLSession.shared.dataTask(with: url) { data, response, error in

            guard let data = data,
                  error == nil,
                  let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300 else {
                print("error downloading data")
                completionHandler(nil)
                return
            }

            completionHandler(data)

        }.resume()
    }
}

struct DownloadWithEacapingSwiftUIView: View {

    @StateObject var vm = DownloadWithEacapingViewModel()

    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

            }
        }
    }
}

#Preview {
    DownloadWithEacapingSwiftUIView()
}
