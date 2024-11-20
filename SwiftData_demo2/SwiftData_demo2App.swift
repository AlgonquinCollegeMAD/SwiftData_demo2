//
//  SwiftData_demo2App.swift
//  SwiftData_demo2
//
//  Created by Vladimir Cezar on 2024.11.20.
//

import SwiftUI

@main
struct SwiftData_demo2App: App {
  var body: some Scene {
    WindowGroup {
      TabView {
        PersonsListView()
          .tabItem {
            Label("Persons", systemImage: "person.2")
          }
        PetsListView()
          .tabItem {
            Label("Pets", systemImage: "pawprint")
          }
      }
    }
    .modelContainer(for: [Person.self, Pet.self])
  }
}
