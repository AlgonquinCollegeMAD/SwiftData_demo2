//
//  PetDetailView.swift
//  SwiftData_demo2
//
//  Created by Vladimir Cezar on 2024.11.20.
//
import SwiftUI
import SwiftData

struct PetDetailView: View {
  @Bindable var pet: Pet
  @Query var persons: [Person]
  @Environment(\.modelContext) private var context
  
  var body: some View {
    VStack {
      Text("Owners of \(pet.name)")
        .font(.headline)
      if pet.owners.isEmpty {
        Text("No owners assigned.")
      } else {
        List(pet.owners) { owner in
          Text(owner.name)
        }
      }
      
      Text("Assign an Owner")
      List {
        ForEach(persons.filter { !pet.owners.contains($0) }) { person in
          Button(person.name) {
            assignOwner(person)
          }
        }
      }
    }
    .padding()
  }
  
  private func assignOwner(_ person: Person) {
    pet.owners.append(person)
    person.pets.append(pet)
    try? context.save()
  }
}
