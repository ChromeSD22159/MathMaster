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
    
    @AppStorage(AppStorageKey.user.rawValue) private var userID: String = ""
    
    @State private var showSheetOnbording = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // MARK: - Background
                VStack {
                    Image("headerGreen")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 167)
                        .ignoresSafeArea(edges: .top)
                    
                    Spacer()
                }
                
                VStack(spacing: 0) {
                    Spacer().frame(height: 167)
                    
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
                }
            }
            .navigationTitle("User")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSheetOnbording = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .tint(.green)
                    }
                }
            }
            .sheet(isPresented: $showSheetOnbording) {
                AddUserSheet()
            }
        }
    }
}

#Preview {
    ShowUser()
        .modelContainer(previewContainer)
}
