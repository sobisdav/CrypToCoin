//
//  CalculatorViewController.swift
//  CrypToCoin
//
//  Created by David Sobíšek on 10.04.2022.
//

import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet weak var calculateButton: UIButton!
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
    }
    @IBOutlet weak var leftCurrencyPicker: UIPickerView!
    @IBOutlet weak var rightCurrencyPicker: UIPickerView!
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculateButton.layer.cornerRadius = 10.0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
