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
    var targetCurrency: String!
    var value = "1.0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculateButton.layer.cornerRadius = 10.0
        resultField.layer.masksToBounds = true
        resultField.layer.cornerRadius = 5.0
        currencyLabel.text = targetCurrency
        valueField.delegate = self
        pickerView.dataSource = self
        pickerView.delegate = self
        
    }
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        resultField.text = value
    }
}

//MARK: - UITextFieldDelegate

extension CalculatorViewController: UITextFieldDelegate {
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        valueField.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        valueField.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }
        else {
            textField.placeholder = "Type something."
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let newValue = valueField.text {
            value = newValue
        }
    }
}

//MARK: - UIPickerViewDataSource & UIPickerViewDelegate

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
