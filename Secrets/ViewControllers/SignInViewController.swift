//
//  SignInViewController.swift
//  Secrets
//
//  Created by James Craige on 4/10/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import UIKit

class SignInViewController: AuthenticationViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func signIn(sender: UIButton) {
        signIn()
    }
    
    func signIn() {
        let _:() = UserAuthenticator.signIn(emailTextField.text, password: passwordTextField.text).then { _ in
            self.presentMainFlow()
        }.catch { error -> Void in
            let message = error.userInfo?["error"] as? String
            self.alertWithTitle("Error", message: message)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        switch textField {
        case emailTextField: passwordTextField.becomeFirstResponder()
        case passwordTextField: signIn()
        default: break
        }

        return true
    }
}
