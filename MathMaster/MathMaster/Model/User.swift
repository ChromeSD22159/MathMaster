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
    var id: UUID
    var userID: String
    var name: String
    var age: Int
    
    @Relationship(inverse: \Statistic.user)
    var games: [Statistic]
    
    init(id: UUID = UUID(), name: String, age: Int, games: [Statistic] = []) {
        self.id = id
        self.userID = id.uuidString
        self.name = name
        self.age = age
        self.games = games
    }
}
