//
//  SignUpViewController.swift
//  Secrets
//
//  Created by James Craige on 4/10/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import UIKit

class SignUpViewController: AuthenticationViewController, UITextFieldDelegate {
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
            case .Success: self.presentMainFlow()
            case .Failure:
                let errorMessage = result.error?.userInfo?["error"] as? String
                self.alertWithTitle("Error", message: errorMessage)
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        switch textField {
        case emailTextField: passwordTextField.becomeFirstResponder()
        case passwordTextField: signUp()
        default: break
        }
  
        return true
    }
}
