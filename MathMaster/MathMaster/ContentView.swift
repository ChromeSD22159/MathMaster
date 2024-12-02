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
                Setup()
            }
            Tab("Zwei", systemImage: "dog") {
                Game()
            }
            Tab("Drei", systemImage: "bird") {
                Stats()
            }
        }
    }
}

#Preview {
    ContentView()
}
