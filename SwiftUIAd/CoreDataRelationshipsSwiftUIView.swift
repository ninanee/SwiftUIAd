//
//  CoreDataRelationshipsSwiftUIView.swift
//  SwiftUIAd
//
//  Created by Yun Ni on 2024-07-25.
//

import SwiftUI
import CoreData

// 3 Entities
// Business Entity
// Department Entity
// Employee Entity

class CoredataManager {

    static let instance = CoredataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext

    init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading core data: \(error)")
            } else {
                print("Successfully loaded the data")
            }
        }
        context = container.viewContext
    }

    func save() {
        do {
            try context.save()
            print("Save successfully")
        } catch let error {
            print("Error saving core data: \(error.localizedDescription)")
        }

    }
}

class CoreDataRelationshipViewModel: ObservableObject {

    let manager = CoredataManager.instance

    @Published var business: [BusinessEntity] = []
    @Published var departments: [DepartmentEntity] = []
    @Published var employees: [EmployeeEntity] = []

    init() {
        getBusiness()
        getDepartments()
        getEmployees()
    }

    func getBusiness() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")

        do {
            business = try manager.context.fetch(request)

        } catch let error {
            print("Error of fetching: \(error.localizedDescription)")
        }

    }

    func getDepartments() {
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")

        do {
            departments = try manager.context.fetch(request)

        } catch let error {
            print("Error of fetching: \(error.localizedDescription)")
        }

    }

    func getEmployees() {
            let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")

            do {
                employees = try manager.context.fetch(request)
            } catch let error {
                print("Error fetching. \(error.localizedDescription)")
            }
        }

    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Apple"
        save()
    }

    func addDepartment() {
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name = "Markting"
        newDepartment.businesses = [business[0]]
        save()
    }

    func addEmployee() {
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.age = 25
        newEmployee.dateJoined = Date()
        newEmployee.name = "Chris"

        newEmployee.business = business[0]
        newEmployee.department = departments[0]
        save()
    }

    func save() {
        business.removeAll()
        departments.removeAll()
        employees.removeAll()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.manager.save()
            self.getBusiness()
            self.getDepartments()
            self.getEmployees()
        }

    }
}



struct CoreDataRelationshipsSwiftUIView: View {

    @StateObject var vm = CoreDataRelationshipViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Button(action: {
                        vm.addEmployee()
                    } , label: {
                        Text("Perform Action")
                            .foregroundStyle(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.cornerRadius(10))
                    })

                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.business) { businessss in
                                BusinessView(entity: businessss)

                            }
                        }
                    }

                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.departments) { department in
                                DepartmentView(entity: department)

                            }
                        }
                    }

                    ScrollView(.horizontal, showsIndicators: true, content: {
                                          HStack(alignment: .top) {
                                              ForEach(vm.employees) { employee in
                                                  EmployeeView(entity: employee)
                                              }
                                          }
                                      })
                }
                .padding()
            }
            .navigationTitle("Relationships")
        }
    }
}

#Preview {
    CoreDataRelationshipsSwiftUIView()
}

struct BusinessView: View {

    let entity: BusinessEntity

    var body: some View {
        VStack(alignment: .leading, spacing: 20, content: {
            Text("Name: \(entity.name ?? "")")
                .bold()

            if let departments = entity.departments?.allObjects as? [DepartmentEntity] {
                Text("Departments")
                    .bold()
                ForEach(departments) { department in
                    Text(department.name ?? "")
                }
            }


            if let employees = entity.employess?.allObjects as? [EmployeeEntity] {
                Text("Employee")
                    .bold()
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        })
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct DepartmentView: View {

    let entity: DepartmentEntity

    var body: some View {
        VStack(alignment: .leading, spacing: 20, content: {
            Text("Name: \(entity.name ?? "")")
                .bold()

            if let businesses = entity.businesses?.allObjects as? [BusinessEntity] {
                Text("Businesses: ")
                    .bold()
                ForEach(businesses) { business in
                    Text(business.name ?? "")
                }
            }


            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employee: ")
                    .bold()
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        })
            .padding()
            .frame(maxWidth: 300, alignment: .leading)
            .background(Color.green.opacity(0.5))
            .cornerRadius(10)
            .shadow(radius: 10)
    }
}

struct EmployeeView: View {

    let entity: EmployeeEntity

    var body: some View {
        VStack(alignment: .leading, spacing: 20, content: {
            Text("Name: \(entity.name ?? "")")
                .bold()

            Text("Age: \(entity.age)")
            Text("Date joined: \(entity.dateJoined ?? Date())")

            Text("Business:")
                .bold()

            Text(entity.business?.name ?? "")

            Text("Department:")
                .bold()

            Text(entity.department?.name ?? "")
        })
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.blue.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}
