//
//  DetailViewController.swift
//  CrypToCoin
//
//  Created by David Sobíšek on 11.04.2022.
//

import UIKit
import Firebase

class DetailViewController: UIViewController {
    @IBOutlet weak var cryptoLabel: UILabel!
    @IBOutlet weak var currentRateLabel: UILabel!
    @IBOutlet weak var calculatorButton: UIButton!
    var cryptoName = "BTC"
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatorButton.titleLabel?.adjustsFontSizeToFitWidth = true
        calculatorButton.titleLabel?.minimumScaleFactor = 0.5
        calculatorButton.layer.cornerRadius = 10.0
        coinManager.delegate = self
        cryptoLabel.text = cryptoName
        coinManager.getPrice(from: cryptoName, to: "USD")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCalculator" {
            // swiftlint:disable force_cast
            let destinationVC = segue.destination as! CalculatorViewController
            // swiftlint:enable force_cast
            destinationVC.targetCurrency = cryptoName
        }
    }
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}

// MARK: - CoinManagerDelegate

extension DetailViewController: CoinManagerDelegate {
    func didUpdatePrice(price: Double) {
        DispatchQueue.main.async {
            self.currentRateLabel.text = "1 \(self.cryptoName) = \(String(format: "%.2f", price)) USD"
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
