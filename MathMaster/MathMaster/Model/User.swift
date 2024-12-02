//
//  User.swift
//  MathMaster
//
//  Created by Christoph Schwalm on 02.12.24.
//

import Foundation
import SwiftData

@Model
class User: Identifiable {
    var id: UUID = UUID()
    var name: String
    var age: Int
    
    @Relationship(inverse: \Game.user) var games: [Game] = []
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}
