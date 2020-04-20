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
       return screenText.firstIndex(of: "=") != nil
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
    /// Make the calculation
    func calculator() -> [String] {
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
        return operationsToReduce
    }
    /// Remove last element
    func removeLastElement() {
        if screenText.last == " " {
            let characterToTrim: Set<Character> = [" "]
            screenText.removeAll(where: {characterToTrim.contains($0)})
        }
        screenText.remove(at: screenText.index(before: screenText.endIndex))
    }
    /// Reset calculator
    func reset() {
        screenText = "0"
    }
}
