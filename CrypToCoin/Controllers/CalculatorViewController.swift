//
//  CalculatorViewController.swift
//  CrypToCoin
//
//  Created by David Sobíšek on 10.04.2022.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var resultField: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var calculateButton: UIButton!
    
    var coinManager = CoinManager()
    var pickerCurrency = "AUD"
    var targetCurrency = "BTC"
    var value = "1.0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculateButton.layer.cornerRadius = 10.0
        resultField.layer.masksToBounds = true
        resultField.layer.cornerRadius = 5.0
        currencyLabel.text = targetCurrency
        coinManager.delegate = self
        valueField.delegate = self
        pickerView.dataSource = self
        pickerView.delegate = self
        
    }
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        resultField.text = "Getting data..."
        coinManager.getPrice(from: pickerCurrency, to: targetCurrency)
    }
}

// MARK: - UITextFieldDelegate

extension CalculatorViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if !textField.text!.isEmpty {
            let doub = Double(textField.text!)
            if doub != nil {
                return true
            } else {
                textField.text = ""
                textField.placeholder = "Enter a number!"
                return false
            }
        } else {
            textField.placeholder = "Enter a number!"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let newValue = textField.text {
            value = newValue
        } else {
            print("Couldn't assign value from input field.")
        }
        textField.endEditing(true)
    }
}

// MARK: - UIPickerViewDataSource & UIPickerViewDelegate

extension CalculatorViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.coinCurrencies.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.coinCurrencies[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerCurrency = coinManager.coinCurrencies[row]
    }
}

// MARK: - CoinManagerDelegate

extension CalculatorViewController: CoinManagerDelegate {
    func didUpdatePrice(price: Double) {
        DispatchQueue.main.async {
            self.resultField.text = String(format: "%.8f", price * Double(self.value)!)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
