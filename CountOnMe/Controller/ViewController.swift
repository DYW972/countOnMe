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
    /// Tap numbers buttons
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        calculator.addNumberForCalculation(number: numberText)
        textView.text = calculator.screenText
    }
    /// Tap operators buttons
    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        guard let operatorText = sender.title(for: .normal) else {
            return
        }
        guard calculator.addOpertorForCalculation(operator: operatorText) else {
            return showAlert(with: "Vous avez déjà ajouté un opérateur.")
        }
        textView.text = calculator.screenText
    }
    /// Tap equal button
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        let resultStatus = calculator.makeCalculation()
        if resultStatus.validity {
            textView.text = calculator.screenText
        } else {
            return showAlert(with: resultStatus.message)
        }
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
