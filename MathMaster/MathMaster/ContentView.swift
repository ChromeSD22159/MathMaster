//
//  ContentView.swift
//  MathMaster
//
//  Created by Leonid Riedel on 02.12.24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    
    
    var body: some View {
        TabView {
            
            Tab("Game", systemImage: "gamecontroller") {
                GameView()
            }
            Tab("Stats", systemImage: "list.clipboard.fill") {
                StatsView()
            }
            Tab("ShowUsers", systemImage: "person.crop.circle.badge.plus") {
                ShowUser()
            }
            Tab("Setup", systemImage: "gear") {
                SetupView()
            }
        }
    }    
}


#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: configuration)
    return ContentView()
        .modelContainer(container)
}
