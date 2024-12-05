//
//  Statistic.swift
//  MathMaster
//
//  Created by Christoph Schwalm on 02.12.24.
//

import Foundation
import SwiftData

@Model
class Statistic : Identifiable {
    var id: UUID
    var gameType: String
    var date: Date
    var points: Int
    var rightAnswers: Int
    var wrongAnswers: Int
    
    var user: User?
    
    init(id: UUID = .init(), gameType: String, date: Date, points: Int, rightAnswers: Int, wrongAnswers: Int) {
        self.id = id
        self.gameType = gameType
        self.date = date
        self.points = points
        self.rightAnswers = rightAnswers
        self.wrongAnswers = wrongAnswers
    }
}


