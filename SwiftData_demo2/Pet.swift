//
//  Pet.swift
//  SwiftData_demo2
//
//  Created by Vladimir Cezar on 2024.11.20.
//

import SwiftData

@Model
class Pet {
    var name: String
    @Relationship var owners: [Person] = []
    
    init(name: String) {
        self.name = name
    }
}
