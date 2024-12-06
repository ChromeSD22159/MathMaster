//
//  ShowUser.swift
//  MathMaster
//
//  Created by Christoph Schwalm on 02.12.24.
//

import SwiftUI
import SwiftData

enum AppStorageKey: String {
  case user
}

struct ShowUser: View {
    @Environment(\.modelContext) var context
    @Query(sort: \User.age, order: .reverse) var user: [User]
    @AppStorage(AppStorageKey.user.rawValue) private var userID: String = ""
    @State private var showSheetOnbording = false
    var body: some View {
        NavigationStack {
            List {
                ForEach(user) { user in
                    HStack {
                        Text("\(user.name)")
                        if user.userID == userID {
                            Image(systemName: "star.fill")
                        }
                        Spacer()
                        Text("\(user.age) Jahre alt")
                    }
                    .onTapGesture {
                        withAnimation {
                            userID = user.userID
                        }
                    }
                }
            }
            .navigationTitle("User")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "plus") {
                        showSheetOnbording = true
                    }
                    .sheet(isPresented: $showSheetOnbording) {
                        OnboardingView()
                    }
                }
            }
        }
    }
}
