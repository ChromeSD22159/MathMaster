//
//  OnboardingView.swift
//  MathMaster
//
//  Created by Christoph Schwalm on 02.12.24.
//

import SwiftUI
import SwiftData

struct OnboardingView: View {
    @Environment(\.modelContext) private var context
    
    @State private var username: String = ""
    @State private var age: String = ""
    
    var body: some View {
        VStack {
            Text("Hello, \(username) ")
            TextField("Enter your name", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Enter your age", text: $age)
                .keyboardType(.numberPad)  // Nur Zahlen erlauben
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button {
                if let ageInt = Int(age) {
                    context.insert(User(name: username, age: ageInt))
                } else {
                    print("Bitte gültiger Alter eingeben!")
                }
                
                
            } label: {
                Text("User speichern")
            }

        }

        
    }
}

#Preview {
    OnboardingView()
}
