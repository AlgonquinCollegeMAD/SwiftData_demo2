//
//  PersonsListView.swift
//  SwiftData_demo2
//
//  Created by Vladimir Cezar on 2024.11.20.
//


import SwiftUI
import SwiftData

struct PersonsListView: View {
  @Query var persons: [Person]
  @Environment(\.modelContext) private var context
  
  @State private var newName: String = ""
  
  var body: some View {
    NavigationStack {
      VStack {
        if persons.isEmpty {
          ContentUnavailableView {
            Label("No Persons.", systemImage: "person.2")
          } description: {
            Text("Add a person to get started.")
          }
        } else {
          List {
            ForEach(persons) { person in
              NavigationLink(destination: PersonDetailView(person: person)) {
                Text(person.name)
              }
            }
            .onDelete(perform: deletePersons)
          }
        }
        HStack {
          TextField("New Person Name", text: $newName)
            .textFieldStyle(RoundedBorderTextFieldStyle())
          Button("Add") {
            addPerson(name: newName)
            newName = ""
          }
        }
        .padding()
      }
      .navigationTitle("Persons")
    }
  }
  
  private func addPerson(name: String) {
    guard !name.isEmpty else { return }
    let newPerson = Person(name: name)
    context.insert(newPerson)
    try? context.save()
  }
  
  private func deletePersons(at offsets: IndexSet) {
    let personsToDelete = offsets.map { persons[$0] }
    for person in personsToDelete {
      context.delete(person)
    }
  }
}
