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
