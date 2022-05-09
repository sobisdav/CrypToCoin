//
//  WelcomeViewController.swift
//  CrypToCoin
//
//  Created by David Sobíšek on 09.05.2022.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {
    @IBOutlet weak var titleLabel: CLTypingLabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "CrypToCoin 🪙"
        loginButton.titleLabel?.adjustsFontSizeToFitWidth = true
        loginButton.titleLabel?.minimumScaleFactor = 0.5
        loginButton.layer.cornerRadius = 10.0
        registerButton.titleLabel?.adjustsFontSizeToFitWidth = true
        registerButton.titleLabel?.minimumScaleFactor = 0.5
        registerButton.layer.cornerRadius = 10.0
    }
    
}
