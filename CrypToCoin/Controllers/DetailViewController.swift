//
//  DetailViewController.swift
//  CrypToCoin
//
//  Created by David Sobíšek on 11.04.2022.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var cryptoLabel: UILabel!
    @IBOutlet weak var currentRateLabel: UILabel!
    @IBOutlet weak var calculatorButton: UIButton!
    var cryptoName: String!
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatorButton.titleLabel?.adjustsFontSizeToFitWidth = true
        calculatorButton.titleLabel?.minimumScaleFactor = 0.5
        calculatorButton.layer.cornerRadius = 10.0
        coinManager.delegate = self
        cryptoLabel.text = cryptoName
        coinManager.getCoinPrice(for: cryptoName)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCalculator" {
            let destinationVC = segue.destination as! CalculatorViewController
            destinationVC.targetCurrency = cryptoName
        }
    }
}

//MARK: - CoinManagerDelegate

extension DetailViewController: CoinManagerDelegate {
    func didUpdatePrice(price: String, currency: String) {
        DispatchQueue.main.async {
            self.currentRateLabel.text = "1 \(currency) = \(price) USD"
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
