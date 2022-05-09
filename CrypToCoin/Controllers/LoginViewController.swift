//
//  LoginViewController.swift
//  CrypToCoin
//
//  Created by David Sobíšek on 09.05.2022.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.titleLabel?.adjustsFontSizeToFitWidth = true
        loginButton.titleLabel?.minimumScaleFactor = 0.5
        loginButton.layer.cornerRadius = 10.0
    }
    
}
