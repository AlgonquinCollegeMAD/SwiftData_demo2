//
//  Person.swift
//  SwiftData_demo2
//
//  Created by Vladimir Cezar on 2024.11.20.
//


import SwiftData

@Model
class Person {
    var name: String
    @Relationship var pets: [Pet] = []
    
    init(name: String) {
        self.name = name
    }
}