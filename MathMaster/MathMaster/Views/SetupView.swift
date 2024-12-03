//
//  Setup.swift
//  MathMaster
//
//  Created by Christoph Schwalm on 02.12.24.
//

import SwiftUI

struct SetupView: View {
    //TODO: refektor
    @AppStorage("Schwierigkeitsgrad") private var selectedPicker = Schwierigkeitsgrad.easy
    @AppStorage("gameDuration") private var gameDuration = 60
    @State private var showSheet = false
    
    var body: some View {
        
        VStack {
            Text("Schwierigkeitsgrad wählen")
                .font(.headline)
                .bold()
            Picker("Schwierigkeitsgrad", selection: $selectedPicker) {
                ForEach(Schwierigkeitsgrad.allCases) { gameType in
                    Text(gameType.rawValue).tag(gameType)
                }
            }
            .pickerStyle(.segmented)
            
            Stepper("Rundenlänge: \(gameDuration) sek.", value: $gameDuration, in: (30...90), step: 10)
            
            Spacer()
            
            Button {
                showSheet = true
            } label: {
                Text("Statistik")
            }
            .buttonStyle(.borderedProminent)
            .sheet(isPresented: $showSheet) {
                StatsView()
                    .presentationDetents([.large,.medium])
            }
            
            
        }
        .padding()
        
        
        
        
    }
}


#Preview {
    SetupView()
}
