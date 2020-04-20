//
//  CalculatorTestCase.swift
//  CountOnMeTests
//
//  Created by Yohan William Dunon on 19/04/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CalculatorTestCase: XCTestCase {
    var calculator: Calculator!
    override func setUp() {
        super.setUp()
        calculator = Calculator(screenText: "0")
    }
    func testGivenExpressionIsCorrectWhenTappedEqualButtonThenResultShouldBeDisplayed() {
        calculator.screenText = "1 + 1"
        XCTAssertTrue(calculator.makeCalculation().validity)
    }
    func testGivenExpressionIsNotCorrectWhenTappedEqualButtonThenAlertShouldBeDisplayed() {
        calculator.screenText = "1 +"
        XCTAssertFalse(calculator.makeCalculation().validity)
    }
    func testGivenLastElementIsAnOperatorWhenAddNewOperatorThenAlertShoulBeDisplayed() {
        let operands = ["+", "-", "✗", "÷"]
        calculator.screenText = "1 +"
        for operand in operands {
             XCTAssertFalse(calculator.addOpertorForCalculation(operator: operand))
        }
    }
    func testGivenTappedEquelButtonWhenScreenTextIsEmptyThenAlertShoudlBeDisplayed() {
        calculator.screenText = "0"
        XCTAssertFalse(calculator.makeCalculation().validity)
    }
    func testGivenResultIsDisplayedWhenTappedNumberButtonThenScreenTextShouldBeRefreshed() {
        let newNumber = "3"
        calculator.screenText = "1 + 1 = 2"
        calculator.addNumberForCalculation(number: newNumber)
        XCTAssertTrue(calculator.screenText == newNumber)
    }
    func testGivenResultIsDisplayedWhenTappedOperatorButtonThenScreenTextShouldBeUpdatedWithNewOperator() {
        let newOperator = "✗"
        calculator.screenText = "1 + 1 = 2"
        XCTAssertTrue(calculator.addOpertorForCalculation(operator: newOperator))
    }
    func testGivenResultIsDisplayedWhenTappedEqualButtonThenScreenTextShoulBeUpdateWithResult() {
        calculator.screenText = "1 + 1"
        let calculation = calculator.makeCalculation()
        XCTAssertTrue(calculation.validity)
        let equalButtonPressedAgain = calculator.makeCalculation()
        XCTAssertTrue(calculator.screenText == equalButtonPressedAgain.message)
    }
}
