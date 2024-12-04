//
//  Setup.swift
//  MathMaster
//
//  Created by Christoph Schwalm on 02.12.24.
//

import SwiftUI

struct SetupView: View {
    //TODO: refektor in englisch
    @AppStorage("user") private var userID: String = ""
    
    @AppStorage("Schwierigkeitsgrad") private var selectedPicker = Schwierigkeitsgrad.easy
    @AppStorage("gameDuration") private var gameDuration = 60
    // @State private var showSheet = false
    @AppStorage("additionToggle") private var additionToggle = false
    @AppStorage("subtractionToggle") private var subtractionToggle = false
    @AppStorage("multiplicationToggle") private var multiplicationToggle = false
    @AppStorage("divisionToggle") private var divisionToggle = false
    
    @State var currentTheme: Theme = .orange
    
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
                    
                    Section {
                        HStack(spacing: 10) {
                            Spacer()
                            
                            ForEach(Theme.allCases, id: \.rawValue) { theme in
                                let size: CGFloat = 150
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(theme.bgGradient)
                                    .opacity(currentTheme == theme ? 1 : 0.5)
                                    .overlay {
                                        if currentTheme == theme {
                                            withAnimation {
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(.white.opacity(0.75), lineWidth: 5)
                                            }
                                        }
                                    }
                                    .frame(width: size, height: size)
                                    .onTapGesture {
                                        withAnimation {
                                            currentTheme = theme
                                        }
                                    }
                            }
                            
                            Spacer()
                        }
                        Picker("Theme", selection: $currentTheme) {
                            ForEach(Theme.allCases, id: \.rawValue) { theme in
                                Text(theme.rawValue).tag(theme)
                            }
                        }
                        .pickerStyle(.segmented)
                        .onChange(of: currentTheme, {
                            ThemeService.setTheme(currentTheme)
                        })
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
        .onAppear {
            currentTheme = ThemeService.currentTheme
        }
    }
}


#Preview {
    SetupView()
}
