//
//  ShowUser.swift
//  MathMaster
//
//  Created by Christoph Schwalm on 02.12.24.
//

import SwiftUI
import SwiftData

struct ShowUser: View {
    @Environment(\.modelContext) var context
    
    @Query(sort: \User.age, order: .reverse) var user: [User]
    
    @State private var showSheetOnbording = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(user) { user in
                        HStack {
                            Text("\(user.name)")
                            Spacer()
                            Text("\(user.age) Jahre alt")
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
