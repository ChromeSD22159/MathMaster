//
//  MathMasterApp.swift
//  MathMaster
//
//  Created by Leonid Riedel on 02.12.24.
//

import SwiftUI
import SwiftData

@main
struct MathMasterApp: App { 
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(localContainer)
                .environment(\.currentTheme, .orange)
        }
    }
}

var localContainer: ModelContainer {
    let schema = Schema([
        User.self,
        Statistic.self
    ])
    let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
    
    return try! ModelContainer(for: schema, configurations: config)
}

var previewContainer: ModelContainer {
    let schema = Schema([
        User.self,
        Statistic.self
    ])
    
    let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
    
    return try! ModelContainer(for: schema, configurations: config)
}
