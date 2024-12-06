//
//  MathOperation.swift
//  MathMaster
//
//  Created by Frederik Kohler on 04.12.24.
//

/// Enum für Rechenarten
enum MathOperation: String, CaseIterable {
    case addition = "+"
    case subtraction = "-"
    case multiplication = "x"
    case division = ":"
    
    var displayOperator: String {
        switch self{
            
        case .addition:
            return "+"
        case .subtraction:
            return "-"
        case .multiplication:
            return "x"
        case .division:
            return ":"
        }
    }
}
