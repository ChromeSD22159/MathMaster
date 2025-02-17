//
//  previewContainer.swift
//  MathMaster
//
//  Created by Frederik Kohler on 04.12.24.
//
import SwiftData
import Foundation

let robert = User(name: "Robert", age: 66)
let statsRobert = [
    Statistic(gameType: "Leicht", date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!, points: 10, rightAnswers: 1, wrongAnswers: 0),
    Statistic(gameType: "Leicht", date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!, points: 20, rightAnswers: 2, wrongAnswers: 0),
    Statistic(gameType: "Leicht", date: Calendar.current.date(byAdding: .day, value: 3, to: Date())!, points: 30, rightAnswers: 3, wrongAnswers: 0)
]

let maria = User(name: "Maria", age: 29)
let statsMaria = [
    Statistic(gameType: "Leicht", date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!, points: 40, rightAnswers: 4, wrongAnswers: 0),
    Statistic(gameType: "Leicht", date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!, points: 50, rightAnswers: 5, wrongAnswers: 0),
    Statistic(gameType: "Leicht", date: Calendar.current.date(byAdding: .day, value: 3, to: Date())!, points: 60, rightAnswers: 6, wrongAnswers: 0)
]


@MainActor
var previewContainer: ModelContainer {
    let schema = Schema([
        User.self,
        Statistic.self
    ])
    
    
    
    let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: schema, configurations: config)
    
    maria.games = statsMaria
    container.mainContext.insert(maria)
    
    robert.games = statsRobert
    container.mainContext.insert(robert)
    
    return container
}
