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
    @Query var user: [User]
    
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
        }
    }
}
