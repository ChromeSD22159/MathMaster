//
//  ContentView.swift
//  MathMaster
//
//  Created by Leonid Riedel on 02.12.24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var users: [User]
    
    @AppStorage("user") private var userID: String = ""
    @State var user: User? = nil
    
    var body: some View {
        TabView {
            Tab("Game", systemImage: "gamecontroller") {
                NavigationStack {
                    HomeView(user: user) 
                }
            }
            Tab("Stats", systemImage: "list.clipboard.fill") {
                StatsView(userID: userID)
            }
            Tab("ShowUsers", systemImage: "person.crop.circle.badge.plus") {
                ShowUser()
            }
            Tab("Setup", systemImage: "gear") {
                SetupView()
            }
        }
        .onAppear {
            insertOrSetUser()
        }
    }
    
    private func insertOrSetUser() {
        if users.count == 0 {
            let user = User(name: "TestUser", age: 24)
            modelContext.insert(user)
            userID = user.userID
            self.user = user
        } else {
            let user = users.first!
            userID = user.userID
            self.user = user
        }
    }
}


#Preview {
    ContentView()
        .modelContainer(previewContainer)
}
