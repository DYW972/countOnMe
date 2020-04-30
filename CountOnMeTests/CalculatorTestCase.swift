//
//  CalculatorTestCase.swift
//  CountOnMeTests
//
//  Created by Yohan William Dunon on 19/04/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

// swiftlint:disable force_cast_bis
class CalculatorTestCase: XCTestCase {
    // MARK: - Properties
    var calculator: Calculator!
    let operands = ["+", "-", "✗", "÷"]

    // MARK: - Main method
    override func setUp() {
        super.setUp()
        calculator = Calculator(screenText: "1 + 1 = 2")
    }

    func doCalculation(with calculationString: String) -> String {
        calculator.screenText = calculationString
        let calculation = calculator.makeCalculation()
        return calculation.message
    }

    // MARK: - Test methods
    func testGivenExpressionIsCorrect_WhenTappedEqualButton_ThenResultShouldBeDisplayed() {
        calculator.screenText = "1 + 1"
        XCTAssertTrue(calculator.makeCalculation().validity)
    }

    func testGivenExpressionIsNotCorrect_WhenTappedEqualButton_ThenAlertShouldBeDisplayed() {
        calculator.screenText = "1 +"
        XCTAssertFalse(calculator.makeCalculation().validity)
    }

    func testGivenLastElementIsAnOperator_WhenAddNewOperator_ThenAlertShoulBeDisplayed() {
        calculator.screenText = "1 +"
        for operand in operands {
             XCTAssertFalse(calculator.addOpertorForCalculation(operator: operand))
        }
    }

    func testGivenTappedEquelButton_WhenScreenTextIsEmpty_ThenAlertShoudlBeDisplayed() {
        calculator.screenText = "0"
        XCTAssertFalse(calculator.makeCalculation().validity)
    }

    func testGivenResultIsDisplayed_WhenTappedNumberButton_ThenScreenTextShouldBeRefreshed() {
        calculator.addNumberForCalculation(number: "3")
        XCTAssertTrue(calculator.screenText == "3")
    }

    func testGivenResultIsDisplayed_WhenTappedOperatorButton_ThenScreenTextShouldBeUpdatedWithNewOperator() {
        XCTAssertTrue(calculator.addOpertorForCalculation(operator: "+"))
    }

    func testGivenResultIsDisplayed_WhenTappedEqualButton_ThenScreenTextShoulBeUpdateWithResult() {
        let calculation = calculator.makeCalculation()
        XCTAssertTrue(calculation.validity)
        XCTAssertTrue(calculator.screenText == calculation.message)
    }

    func testGivenCalculationIsAddition_WhenTappedEqualButton_ThenResultShouldBeThree() {
        let result = doCalculation(with: "2 + 1")
        XCTAssertTrue(calculator.screenText.contains(" = \(result)"))
    }

    func testGivenCalculationIsSubstraction_WhenTappedEqualButton_ThenResultShouldBeOne() {
        let result = doCalculation(with: "2 - 1")
        XCTAssertTrue(calculator.screenText.contains(" = \(result)"))
    }

    func testGivenCalculationIsMultiplication_WhenTappedEqualButton_ThenResultShouldBeOne() {
        let result = doCalculation(with: "2 ✗ 1")
        XCTAssertTrue(calculator.screenText.contains(" = \(result)"))
    }

    func testGivenCalculationIsTwoDivideByOne_WhenTappedEqualButton_ThenResultShouldBeOne() {
        let result = doCalculation(with: "2 ÷ 1")
        XCTAssertTrue(calculator.screenText.contains(" = \(result)"))
    }

    func testGivenResultIsDisplayed_WhenTappedDeleteButton_ThenScreenTextRemoveResultAndLastCalculationElement() {
        calculator.removeLastElement()
        XCTAssertTrue(calculator.screenText == "1 + ")
    }

    func testGivenScreenTextDisplaysZero_WhenTappedDeleteButton_ThenScreenTextStillDisplaysZero() {
        calculator.screenText = "0"
        calculator.removeLastElement()
        XCTAssertTrue(calculator.screenText == "0")
    }

    func testGivenResultIsDisplayed_WhenTappedResetButton_ThenScreenTextShouldBeEqualToZero() {
        calculator.reset()
        XCTAssertTrue(calculator.screenText == "0")
    }
}
