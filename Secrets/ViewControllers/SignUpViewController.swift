//
//  SignUpViewController.swift
//  Secrets
//
//  Created by James Craige on 4/10/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import UIKit
import LlamaKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func signUp(sender: UIButton?) {
        signUp()
    }
    
    func signUp() {
        let email = emailTextField.text
        let password = passwordTextField.text
        
        UserAuthenticator.signUp(email, password: password) { result in
            switch result {
            case .Success: self.alertWithTitle("Success", message: "You signed up!")
            case .Failure:
                let errorMessage = result.error?.userInfo?["error"] as? String
                self.alertWithTitle("Error", message: errorMessage)
            }
        }
    }
    
    func alertWithTitle(title: String, message: String?) {
        let errorMessage = message ?? "An unknown error has occured"
        UIAlertView(title: title, message: errorMessage, delegate: nil, cancelButtonTitle: "OK").show()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            emailTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            passwordTextField.resignFirstResponder()
            signUp()
        default: break
        }
        
        return true
    }
}
