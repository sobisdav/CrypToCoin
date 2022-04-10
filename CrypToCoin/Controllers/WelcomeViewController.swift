//
//  ViewController.swift
//  CrypToCoin
//
//  Created by David Sobíšek on 07.04.2022.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var calculatorButton: UIButton!
    @IBAction func calculatorButtonPressed(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculatorButton.titleLabel?.adjustsFontSizeToFitWidth = true
        calculatorButton.titleLabel?.minimumScaleFactor = 0.5
        calculatorButton.layer.cornerRadius = 10.0
    }


}

