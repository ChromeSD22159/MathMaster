//
//  previewContainer.swift
//  MathMaster
//
//  Created by Frederik Kohler on 04.12.24.
//
import SwiftData
import Foundation

@MainActor
var previewContainer: ModelContainer {
    let schema = Schema([
        User.self,
        Statistic.self
    ])
    
    let statistics = [
        Statistic(name: "TestPerson1", gameType: "", date: Date(), points: 50, rightAnswers: 5, wrongAnswers: 0),
        Statistic(name: "TestPerson2", gameType: "", date: Date(), points: 20, rightAnswers: 5, wrongAnswers: 3),
        Statistic(name: "TestPerson3", gameType: "", date: Date(), points: -30, rightAnswers: 1, wrongAnswers: 4)
    ]
    
    let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: schema, configurations: config)
    
    for statistic in statistics {
        container.mainContext.insert(statistic)
    }
    
    return container
}
