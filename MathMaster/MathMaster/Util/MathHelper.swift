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
  @AppStorage("Schwierigkeitsgrad") private static var selectedDifficultyString: String = "Leicht"
  @AppStorage("additionToggle") private static var additionToggle = false
  @AppStorage("subtractionToggle") private static var subtractionToggle = false
  @AppStorage("multiplicationToggle") private static var multiplicationToggle = false
  @AppStorage("divisionToggle") private static var divisionToggle = false
  static func generateRandomMath() -> Math {
    var maxResult: Int = 20
    var selectedDifficulty: Schwierigkeitsgrad {
      get {
        return Schwierigkeitsgrad(rawValue: selectedDifficultyString) ?? .easy
      }
      set {
        selectedDifficultyString = newValue.rawValue
      }
    }
    switch selectedDifficulty {
      case .easy : maxResult = 20
      case .medium: maxResult = 50
      case .hard: maxResult = 100
    }
    var operations: [MathOperation] = []
    //let operation = MathOperation.allCases.randomElement()!
    if additionToggle {
      operations.append(MathOperation.addition)
    }
    if subtractionToggle {
      operations.append(MathOperation.subtraction)
    }
    if multiplicationToggle {
      operations.append(MathOperation.multiplication)
    }
    if divisionToggle {
      operations.append(MathOperation.division)
    }
    let operation = operations.randomElement() ?? MathOperation.addition
    print (selectedDifficulty)
    var number1: Int
    var number2: Int
    var result: Int
    repeat {
      number1 = Int.random(in: 1...maxResult)
      number2 = Int.random(in: 1...maxResult)
      print("\(number1) \(number2)")
      switch operation {
        case .addition: result = number1 + number2
        case .subtraction: result = number1 - number2
        case .multiplication: result = number1 * number2
        case .division:
          if number2 != 0 {
            //result = number1
            result = number1 * number2
          } else {
            result = maxResult + 1
          }
      }
    } while result > maxResult || result < 0
    return Math(displayText: "\(number1) \(operation.displayOperator) \(number2)", result: result)
  }
}
