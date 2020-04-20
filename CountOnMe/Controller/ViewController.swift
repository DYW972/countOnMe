//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    // MARK: - Properties
    lazy var calculator = Calculator(screenText: textView.text)
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - View actions
    /// Tap number
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        if calculator.expressionHaveResult {
            textView.text = ""
        }
        if calculator.screenText == "0" {
            calculator.screenText = numberText
        } else {
            calculator.screenText.append(numberText)
        }
        textView.text = calculator.screenText
    }
    /// Tap operator
    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        guard let operatorText = sender.title(for: .normal) else {
            return
        }
        if calculator.canAddOperator {
            calculator.screenText.append(" \(operatorText) ")
            textView.text = calculator.screenText
        } else {
            showAlert(with: "Un operateur est déja mis !")
        }
    }
    /// Tap equal button
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard calculator.expressionIsCorrect else {
            return showAlert(with: "Entrez une expression correcte !")
        }
        guard calculator.expressionHaveEnoughElement else {
         return showAlert(with: "Démarrez un nouveau calcul !")
        }
        let result = calculator.calculator()
        print(result)
        textView.text.append(" = \(result.first!)")
    }
    /// Tap AC button
    @IBAction func tappedResetButton(_ sender: UIButton) {
        calculator.reset()
        textView.text = calculator.screenText
    }
    /// Tap Del button
    @IBAction func tappedDelButton(_ sender: UIButton) {
        calculator.removeLastElement()
        textView.text = calculator.screenText
    }
    // MARK: Methods
    func showAlert(with message: String) {
        let alertVC = UIAlertController(title: "Erreur :",
                                        message: message,
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
