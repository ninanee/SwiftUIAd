//
//  FileManagerSwiftUIView.swift
//  SwiftUIAd
//
//  Created by Yun Ni on 2024-07-29.
//

import SwiftUI

class LocatFileManager {

    static let instance = LocatFileManager()
    let folderName: String = "MyApp_Image"

    init() {
        createFolderIfNeeded()
    }

    func createFolderIfNeeded() {
        guard let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
            .path(percentEncoded: true) else {
            return
        }
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                print("Success creating folder")
            } catch let error {
                print("Error creating folder. \(error.localizedDescription) ")

            }
        }
    }

    func saveImage(image: UIImage, name: String) -> String{

        guard let data = image.jpegData(compressionQuality: 1.0) else {return "Error getting path." }

//        //let directory1 = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        let directory2 = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
//
//        let path = directory2?.appendingPathComponent("\(name).jpg")

        // another way to write the path

        guard let path = getPathForImage(name: name)  else {
            return "Error getting path."
        }

        do {
            try data.write(to: path)
            print(path)
            return ("Success saving")
        } catch let error {
            return ("Error saving \(error)")
        }
//
//        print(directory2)
//        print(path)



       // let directory3 = FileManager.default.temporaryDirectory
        //data.write(to: <#T##URL#>)

//        print(directory1)
//        print(directory2)
//        print(directory3)

    }

    func getPathForImage(name: String) -> URL? {

        guard let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathExtension(folderName)
            .appendingPathComponent("\(name).jpg") else {
            print("Error getting path.")
            return nil
        }

        return path
    }

    func getImages(name: String) -> UIImage? {

        guard 
            let path = getPathForImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path) else {
            print("Error getting path.")
            return nil
        }
        return UIImage(contentsOfFile: path)
    }

    func deleteImage(name: String) -> String{
        guard
            let path = getPathForImage(name: name),
            FileManager.default.fileExists(atPath: path.path) else {
            print("Error getting path.")
            return "Error getting path."
        }

        do{
            try FileManager.default.removeItem(at: path)
          return "delete succeffully"
        }
        catch let error {
            print("Error deleting image. \(error.localizedDescription)")
            return "Error deleting image."
        }

    }
}

class FileManagerViewModel: ObservableObject {

    @Published var inforMessage: String = ""
    @Published var image: UIImage? = nil
    let manager = LocatFileManager.instance
    let imageName = "steve"

    init() {
        getImaheFromAssetFolder()
    }

    func getImaheFromAssetFolder() {
        image = UIImage(named: imageName)
    }

    func saveImage() {
        guard let image = image else {return}
        inforMessage = manager.saveImage(image: image, name: imageName)
    }

    func getImageForFileFolder() {
        image = UIImage(named: imageName)
    }

    func deleteImage() {
        inforMessage =  manager.deleteImage(name: imageName)
    }
}

struct FileManagerSwiftUIView: View {

    @StateObject var vm = FileManagerViewModel()
    var body: some View {
        NavigationView {
            VStack{

                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }

                HStack {
                    Button(action: {
                        vm.deleteImage()
                    }, label: {
                        Text("delete from FM")
                            .foregroundStyle(.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .background(Color.red)
                            .cornerRadius(10)
                    })

                    Button(action: {
                        vm.saveImage()
                    }, label: {
                        Text("Save to FM")
                            .foregroundStyle(.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .background(Color.blue)
                            .cornerRadius(10)
                    })
                }

                Text(vm.inforMessage)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(.purple)


                Spacer()
            }
            .navigationTitle("File Manager")
        }
    }
}

#Preview {
    FileManagerSwiftUIView()
}
