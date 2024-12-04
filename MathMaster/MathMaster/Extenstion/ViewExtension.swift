//
//  ViewExtension.swift
//  MathMaster
//
//  Created by Frederik Kohler on 04.12.24.
//

import SwiftUI

extension View {
    func cardStyle(color: Color? = nil) -> some View {
        modifier(CardStyle(color: color))
    }
}

struct CardStyle: ViewModifier {
    let color: Color?
    func body(content: Content) -> some View {
        if let color = color {
            content
                .padding()
                .background(color)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .font(.headline)
                .padding(.horizontal, 30)
        } else {
            content
                .padding()
                .background(Material.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .font(.headline)
                .padding(.horizontal, 30)
        }
    }
}
