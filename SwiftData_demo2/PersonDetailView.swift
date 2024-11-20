//
//  PersonDetailView.swift
//  SwiftData_demo2
//
//  Created by Vladimir Cezar on 2024.11.20.
//

import SwiftUI
import SwiftData

struct PersonDetailView: View {
  @Bindable var person: Person
  @Query var pets: [Pet]
  @Environment(\.modelContext) private var context
  
  var body: some View {
    VStack {
      Text("Pets for \(person.name)")
        .font(.headline)
      if person.pets.isEmpty {
        Text("No pets assigned.")
      } else {
        List(person.pets) { pet in
          Text(pet.name)
        }
      }
      
      Text("Assign a Pet")
      List {
        ForEach(pets.filter { !person.pets.contains($0) }) { pet in
          Button(pet.name) {
            assignPet(pet)
          }
        }
      }
    }
    .padding()
  }
  
  private func assignPet(_ pet: Pet) {
    person.pets.append(pet)
    pet.owners.append(person)
    try? context.save()
  }
}
