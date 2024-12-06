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
    
    @AppStorage(AppStorageKey.user.rawValue) private var userID: String = ""
    
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
        .onChange(of: userID) {
            let user = users.first(where: { $0.userID == userID })
            
            if let foundUser = user {
                userID = foundUser.userID
                self.user = foundUser
            }
        }
    }
    
    private func insertOrSetUser() {
        if users.count == 0 {
            let user = User(name: "TestUser", age: 24)
            modelContext.insert(user)
            userID = user.userID
            self.user = user
        } else {
            let user = users.first(where: { $0.userID == userID })
            
            if let foundUser = user {
                userID = foundUser.userID
                self.user = foundUser
            }
        }
    }
}


#Preview {
    ContentView()
        .modelContainer(previewContainer)
}
