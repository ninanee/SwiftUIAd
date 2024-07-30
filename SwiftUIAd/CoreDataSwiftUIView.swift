//
//  CoreDataSwiftUIView.swift
//  SwiftUIAd
//
//  Created by Yun Ni on 2024-07-24.
//

import SwiftUI
import CoreData

// View -> UI
// Model -> Data point
// ViewModel -> manages the data for a view

class CoreDataViewModel: ObservableObject {

    @Published var savedEntities: [FruitEntity] = []
    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading core data: \(error)")
            } else {
                print("Successfully loaded the data")
            }
        }
        fetchFruits()
    }

    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")

        do {
            savedEntities =  try container.viewContext.fetch(request)
        } catch let error {
            print("ERROR FETCHING. \(error)")
        }

    }

    func addFruit(text: String) {
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = text
        saveData()
    }

    func updateFruit(entity: FruitEntity) {
        let currentName = entity.name ?? ""
        let newName = currentName + "!"
        entity.name = newName

        saveData()
    }

    func deleteFruit(indexSet: IndexSet) {
        guard let index = indexSet.first else {return}
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }

    func saveData() {
        do {
            try container.viewContext.save()
            // since we need to update the UI with publised obj
            fetchFruits()
        } catch let error {
            print("Error saving \(error)")
        }

    }
}

struct CoreDataSwiftUIView: View {

    @StateObject var vm = CoreDataViewModel()
    @State var texfiledText = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Add fruits here...", text: $texfiledText)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(Color.gray)
                    .cornerRadius(10)
                    .padding(.horizontal)

                Button(action: {
                    guard !texfiledText.isEmpty else {return}
                    vm.addFruit(text: texfiledText)
                }, label: {
                    Text("Save")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.pink)
                        .cornerRadius(10)
                        .padding(.horizontal)

                })
                .padding(.horizontal)

                List {
                    ForEach(vm.savedEntities) { entity in
                        Text(entity.name ?? "NO NAME")
                            .onTapGesture {
                                vm.updateFruit(entity: entity)
                            }
                    }
                    .onDelete(perform: vm.deleteFruit)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Fruits")
        }
    }
}

#Preview {
    CoreDataSwiftUIView()
}
