//
//  Calculator.swift
//  CountOnMe
//
//  Created by Yohan William Dunon on 20/04/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {
    // MARK: - Properties
    var screenText = String()
    var elements: [String] {
       return screenText.split(separator: " ").map { "\($0)" }
    }
    var canAddOperator: Bool {
        checkValidity()
    }
    var expressionHaveResult: Bool {
        return screenText.contains("=")
    }
    var expressionIsCorrect: Bool {
      checkValidity()
    }
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

    // MARK: - Init
    init(screenText: String) {
        if screenText == "0" {
            self.screenText = ""
        } else {
            self.screenText = screenText
        }
    }

    // MARK: - Methods
    /// Check if last element is an operator when equal button is pressed
    func checkValidity() -> Bool {
      return elements.last != "+" && elements.last != "-" && elements.last != "✗" && elements.last != "÷"
    }

    /// Add number for calculation
    func addNumberForCalculation(number: String) {
        if expressionHaveResult {
            screenText = ""
        }
        if screenText == "0" {
            screenText = number
        } else {
            screenText.append("\(number)")
        }
    }

    /// Add operator for calculation
    func addOpertorForCalculation(operator symbol: String) -> Bool {
        print(elements)
        if canAddOperator {
            if expressionHaveResult {
                screenText = elements.last!
            }
            screenText.append(" \(symbol) ")
            return true
        }
        return false
    }

    /// Make the calculation
    func makeCalculation() -> (validity: Bool, message: String) {
        if !expressionIsCorrect {
            return (false, "Veuillez entrer une expression correcte.")
        }
        if !expressionHaveEnoughElement {
            return (false, "Veuillez démarrer un nouveau calcul.")
        }
        if expressionHaveResult {
            screenText = elements.last!
            return (true, "\(elements.last!)")
        }
        /// - parameters operationsToReduce: Create local copy of operations
        var operationsToReduce = elements
        /// Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
            let result: Int
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "✗": result = left * right
            case "÷": result = left / right
            default: fatalError("Unknown operator !")
            }
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        screenText.append(" = \(operationsToReduce.first!)")
        return (true, "")
    }

    /// Remove last element
    func removeLastElement() {
        if screenText == "0" {
            return
        }

        if expressionHaveResult {
            if let firstCharacterToTrim = screenText.firstIndex(of: "=") {
                for character in screenText {
                    if let index = screenText.lastIndex(of: character) {
                        if index >= screenText.index(before: firstCharacterToTrim) {
                            screenText.remove(at: index)
                        }
                    }
                }
            } else {
                screenText = "0"
            }
        }

        screenText.remove(at: screenText.index(before: screenText.endIndex))

        if screenText.isEmpty {
            screenText = "0"
        }
    }

    /// Reset calculator
    func reset() {
        screenText = "0"
    }
}
