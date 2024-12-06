//
//  AlertView.swift
//  MathMaster
//
//  Created by Maria Schulte on 06.12.24.
//

import SwiftUI

struct AlertView: View {
    var points: Int
    var home: () -> Void
    var newGame: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Toll gemacht!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.mint)
                
                Text("Deine Punkte: \(points)")
                    .font(.headline)
                
                
                HStack {
                    Button(action: home) {
                        Text("Home")
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                    
                    Button(action: newGame) {
                        Text("Neues Spiel")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 10)
            .frame(width: 300)
        }
    }
}

#Preview {
    AlertView(
        points: 40,
        home: {},
        newGame: {}
    )
}
