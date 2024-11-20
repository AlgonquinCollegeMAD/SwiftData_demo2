//
//  PetsListView.swift
//  SwiftData_demo2
//
//  Created by Vladimir Cezar on 2024.11.20.
//


import SwiftUI
import SwiftData

struct PetsListView: View {
  @Query var pets: [Pet]
  @Environment(\.modelContext) private var context
  
  @State private var newName: String = ""
  
  var body: some View {
    NavigationStack {
      VStack {
        if pets.isEmpty {
          ContentUnavailableView {
            Label("No Pets.", systemImage: "pawprint")
          } description: {
            Text("Add a pet to get started.")
          }
        } else {
          List {
            ForEach(pets) { pet in
              NavigationLink(destination: PetDetailView(pet: pet)) {
                Text(pet.name)
              }
            }
            .onDelete(perform: deletePets)
          }
        }
        HStack {
          TextField("New Pet Name", text: $newName)
            .textFieldStyle(RoundedBorderTextFieldStyle())
          Button("Add") {
            addPet(name: newName)
            newName = ""
          }
        }
        .padding()
      }
      .navigationTitle("Pets")
    }
  }
  
  private func addPet(name: String) {
    guard !name.isEmpty else { return }
    let newPet = Pet(name: name)
    context.insert(newPet)
    try? context.save()
  }
  
  private func deletePets(at offsets: IndexSet) {
    let petsToDelete = offsets.map { pets[$0] }
    for pet in petsToDelete {
      context.delete(pet)
    }
  }
}
