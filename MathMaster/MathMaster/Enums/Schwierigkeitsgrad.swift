//
//  Schwierigkeitsgrad.swift
//  MathMaster
//
//  Created by Christoph Schwalm on 02.12.24.
//

enum Schwierigkeitsgrad: String, CaseIterable, Identifiable {
    case easy = "Leicht"
    case medium = "Mittel"
    case hard = "Schwer"
    
    var id: String { self.rawValue }
    
    static func from(string: String) -> Schwierigkeitsgrad? {
        return Schwierigkeitsgrad(rawValue: string)
    }
}
