//
//  RegisterViewController.swift
//  CrypToCoin
//
//  Created by David Sobíšek on 09.05.2022.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.titleLabel?.adjustsFontSizeToFitWidth = true
        registerButton.titleLabel?.minimumScaleFactor = 0.5
        registerButton.layer.cornerRadius = 10.0
        emailField.delegate = self
        passwordField.delegate = self
    }
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailField.text, let password = passwordField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let err = error {
                    print(err)
                } else {
                    self.performSegue(withIdentifier: Constants.registerSegue, sender: self)
                }
            }
        } else {
            if emailField.text == "" {
                emailField.placeholder = "Enter email!"
            }
            if passwordField.text == "" {
                passwordField.placeholder = "Enter password!"
            }
        }
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
