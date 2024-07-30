//
//  CodableSwiftUIView.swift
//  SwiftUIAd
//
//  Created by Yun Ni on 2024-07-25.
//

import SwiftUI

struct CustomerModel: Identifiable, Decodable {
    let id: String
    let name: String
    let points: Int
    let isPremium: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case points
        case isPremium
    }

    init(id: String, name: String, points: Int, isPremium: Bool) {
        self.id = id
        self.name = name
        self.points = points
        self.isPremium = isPremium
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.points = try container.decode(Int.self, forKey: .points)
        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)

    }
}

class CodableViewModel: ObservableObject {

    @Published var customer: CustomerModel? = nil
//    @Published var customer: CustomerModel? = CustomerModel(id: "1", name: "Nick", points: 4, isPremium: true)

    init() {
        getData()
    }

    func getData() {
        guard let data = getJSONData() else {return}


        /* //decode method: 1
        print("JSON DATA: ")
        print(data)
        let jsonString = String(data: data, encoding: .utf8)
        print(jsonString ?? "")
         */


        /* //decode method: 2


        if
        let localData = try? JSONSerialization.jsonObject(with: data),
        let dictionary = localData as? [String:Any],
        let id = dictionary["id"] as? String,
        let name = dictionary["name"] as? String,
        let points = dictionary["points"] as? Int,
        let isPremium = dictionary["isPremium"] as? Bool
        {
            let newCustomer = CustomerModel(id: id, name: name, points: points, isPremium: isPremium)
            customer = newCustomer
        }
         */

        do {
            self.customer = try JSONDecoder().decode(CustomerModel.self, from: data)
        } catch let error {
            print("Error decodin: \(error.localizedDescription)")
        }
    }


    // Might NOT GET THE DATA, SO using OPTIONAL
    func getJSONData() -> Data? {

        let dictionary: [String:Any] = [
            "id" : "12345",
            "name" : "Joe",
            "points" : 5,
            "isPremium" : true
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])

        return jsonData
    }
}


struct CodableSwiftUIView: View {

    @StateObject var vm = CodableViewModel()

    var body: some View {
        VStack(spacing: 20){
            if let cx = vm.customer {
                Text(cx.id)
                Text(cx.name)
                Text("\(cx.points)")
                Text(cx.isPremium.description)

            }
        }

    }
}

#Preview {
    CodableSwiftUIView()
}
