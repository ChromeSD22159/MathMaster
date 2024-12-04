//
//  localContainer.swift
//  MathMaster
//
//  Created by Frederik Kohler on 04.12.24.
//
import SwiftData

var localContainer: ModelContainer {
    let schema = Schema([
        User.self,
        Statistic.self
    ])
    
    let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
    
    return try! ModelContainer(for: schema, configurations: config)
}
