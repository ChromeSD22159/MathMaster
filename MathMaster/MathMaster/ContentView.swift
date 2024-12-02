//
//  ContentView.swift
//  MathMaster
//
//  Created by Leonid Riedel on 02.12.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Eins", systemImage: "cat") {
                SetupView()
            }
            Tab("Zwei", systemImage: "dog") {
                GameView()
            }
            Tab("Drei", systemImage: "bird") {
                StatsView()
            }
        }
    }
}

#Preview {
    ContentView()
}
