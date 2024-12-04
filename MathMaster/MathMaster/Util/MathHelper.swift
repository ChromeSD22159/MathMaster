//
//  MathHelper.swift
//  MathMaster
//
//  Created by Frederik Kohler on 04.12.24.
//
import Foundation
import SwiftUI

/// MathHelper zur Generierung von Rechenaufgaben
struct MathHelper {
    @AppStorage("difficultyLevel") private static var difficultyLevel: String = "leicht"

    static func generateRandomMath() -> Math {
        var maxResult: Int = 20
        
        if let level = Schwierigkeitsgrad(rawValue: difficultyLevel) {
            switch level {
                case .easy : maxResult = 20
                case .medium: maxResult = 50
                case .hard: maxResult = 100
            }
        }
        
        let operation = MathOperation.allCases.randomElement()!

        var number1: Int
        var number2: Int
        var result: Int

        repeat {
            number1 = Int.random(in: 1...maxResult)
            number2 = Int.random(in: 1...maxResult)
            
            switch operation {
                case .addition: result = number1 + number2
                case .subtraction: result = number1 - number2
                case .multiplication: result = number1 * number2
                case .division:
                    if number2 != 0 {
                        result = number1
                        number1 = number1 * number2
                    } else {
                        result = maxResult + 1
                    }
            }
        } while result > maxResult || result < 0

        return Math(displayText: "\(number1) \(operation.rawValue) \(number2)", result: result)
    }
}
