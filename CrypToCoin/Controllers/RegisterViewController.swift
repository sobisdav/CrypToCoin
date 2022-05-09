//
//  RegisterViewController.swift
//  CrypToCoin
//
//  Created by David Sobíšek on 09.05.2022.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.titleLabel?.adjustsFontSizeToFitWidth = true
        registerButton.titleLabel?.minimumScaleFactor = 0.5
        registerButton.layer.cornerRadius = 10.0
    }
    
}
