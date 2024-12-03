//
//  Setup.swift
//  MathMaster
//
//  Created by Christoph Schwalm on 02.12.24.
//

import SwiftUI

struct SetupView: View {

    @AppStorage("selectedPicker") private var selectedPicker = Schwierigkeitsgrad.easy
    
    var body: some View {
        
            Picker("Schwierigkeitsgrad", selection: $selectedPicker) {
                ForEach(Schwierigkeitsgrad.allCases) { gameType in
                    Text(gameType.rawValue).tag(gameType)
                }
            }
            .pickerStyle(.segmented)
            .padding()
        
        
    }
}


#Preview {
    SetupView()
}
