//
//  OnboardingView.swift
//  MathMaster
//
//  Created by Christoph Schwalm on 02.12.24.
//  Edited by Maria Schulte on 06.12.24

import SwiftUI
import SwiftData

struct AddUserSheet: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    
    @State private var username: String = ""
    @State private var age: String = ""
    
    @AppStorage(AppStorageKey.user.rawValue) private var userID: String = ""
    
    var body: some View {
        ZStack{
            // MARK: - Background
            VStack {
                Image("backgroundNameGreen")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 369)
                    .ignoresSafeArea(edges: .top)
                
                Spacer()
            }
            
            VStack(alignment: .leading) {
                HStack{
                    Spacer()
                    Text("Hallo!".uppercased())
                        .font(.system(size: 48))
                        .fontWeight(.bold)
                        .offset(y: -50)
                }
                .padding(24)
                
                Text("Wie heißt du?")
                    .font(.title2)
                
                
                TextField("Name", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text("Wie alt bist du?")
                    .font(.title2)
                TextField("Alter", text: $age)
                    .keyboardType(.numberPad)  // Nur Zahlen erlauben
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                HStack{
                    Spacer()
                    Button {
                        if let ageInt = Int(age) {
                            let user = User(name: username, age: ageInt)
                            context.insert(user)
                            userID = user.userID
                            dismiss()
                        } else {
                            print("Bitte gültiges Alter eingeben!")
                        }
                    } label: {
                        Text("Speichern")
                            .foregroundStyle(.white)
                            .frame(width: 120, height: 40)
                            .background(Color.gray)
                            .cornerRadius(10)
                            .shadow(color: .gray, radius: 5, x: 0, y: 5)
                    }

                }
            }
            .padding(24)
        }
    }
}

#Preview {
    AddUserSheet()
}
