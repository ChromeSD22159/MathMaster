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
                .modelContainer(modelContainer)
                .environment(\.currentTheme, .orange)
        }
    }
}

var modelContainer: ModelContainer {
    let schema = Schema([
        User.self
    ])
    let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
    
    return try! ModelContainer(for: schema, configurations: config)
}
