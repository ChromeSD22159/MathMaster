//
//  ViewExtension.swift
//  MathMaster
//
//  Created by Frederik Kohler on 04.12.24.
//

import SwiftUI

extension View {
    func cardStyle() -> some View {
        modifier(CardStyle())
    }
}

struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Material.ultraThin)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .font(.headline)
            .padding(.horizontal, 30)
    }
}
