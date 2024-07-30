//
//  CacheImagesSwiftUIView.swift
//  SwiftUIAd
//
//  Created by Yun Ni on 2024-07-30.
//

import SwiftUI


class CacheManager {

    static let instance = CacheManager()

    private init() {

    }

    // <key, value>. might save as data instead of image
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 // 100mb, the total data that we can put in the cache
        return cache
    }()

    func add(image: UIImage, name: String) {
        imageCache.setObject(image, forKey: name as NSString)
        print("Added to cache!")
    }

    func remove(name: String) {
        imageCache.removeObject(forKey: name as NSString)
        print("Removed from the cache!")
    }

    func get(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }

}
class CacheViewModel: ObservableObject {
    @Published var statartingImage: UIImage? = nil
    @Published var cachedImage: UIImage? = nil

    let manager = CacheManager.instance
    let imageName: String = "steve"

    init() {

        getImageFromAssetsFolder()
    }

    func getImageFromAssetsFolder() {
        statartingImage = UIImage(named: imageName)
    }

    func savetoCache() {
        guard let image = statartingImage else {return }
        manager.add(image: image, name: imageName)
    }

    func removeFromCache() {
        manager.remove(name: imageName)
    }

    func getFromCache(){
        cachedImage = manager.get(name: imageName)
    }

}

struct CacheImagesSwiftUIView: View {

    @StateObject var vm = CacheViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if let vmimage = vm.statartingImage {
                    Image(uiImage: vmimage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)

                }

                HStack {
                    Button(action: {
                        vm.savetoCache()
                    }, label: {
                        Text("Save to Cache")
                            .foregroundStyle(.white)
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    })

                    Button(action: {
                        vm.removeFromCache()
                    }, label: {
                        Text("Delete from Cache")
                            .foregroundStyle(.white)
                            .font(.headline)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    })

                    Button(action: {
                        vm.getFromCache()
                    }, label: {
                        Text("Get from Cache")
                            .foregroundStyle(.white)
                            .font(.headline)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    })

                }

                if let image = vm.cachedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)

                }
                Spacer()
            }
            .navigationTitle("Cached Title")
        }
    }
}

#Preview {
    CacheImagesSwiftUIView()
}
