//
//  Setup.swift
//  MathMaster
//
//  Created by Christoph Schwalm on 02.12.24.
//

import SwiftUI

struct SetupView: View {
    //TODO: refektor in englisch
    @AppStorage("Schwierigkeitsgrad") private var selectedPicker = Schwierigkeitsgrad.easy
    @AppStorage("gameDuration") private var gameDuration = 60
//    @State private var showSheet = false
    @AppStorage("additionToggle") private var additionToggle = false
    @AppStorage("subtractionToggle") private var subtractionToggle = false
    @AppStorage("multiplicationToggle") private var multiplicationToggle = false
    @AppStorage("divisionToggle") private var divisionToggle = false
    
    var body: some View {
        
        NavigationStack {
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
                .padding()
                
                Form {
                    Section("Rundenlänge") {
                        Stepper("Rundenlänge: \(gameDuration) sek.", value: $gameDuration, in: (30...90), step: 10)
                        
                        NavigationLink("Statistik"){
                            StatsView()
//                            Button {
//                                showSheet = true
//                            } label: {
//                                Text("Statistik")
//                            }
//                         .buttonStyle(.borderedProminent)
                        }
//                        .sheet(isPresented: $showSheet) {
//                            StatsView()
//                                .presentationDetents([.large,.medium])
//                        }
                    }
                    
                    Section("Grundrechenarten") {
                        Toggle("Addition", systemImage: "plus", isOn: $additionToggle)
                        Toggle("Subtraktion", systemImage: "minus", isOn: $subtractionToggle)
                        Toggle("Multiplikation", systemImage: "multiply", isOn: $multiplicationToggle)
                        Toggle("Division", systemImage: "divide", isOn: $divisionToggle)
                    }
                }
            }
        }
    }
}


#Preview {
    SetupView()
}
