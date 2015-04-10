//
//  SignInViewController.swift
//  Secrets
//
//  Created by James Craige on 4/10/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func signIn(sender: UIButton) {
        signIn()
    }
    
    func signIn() {
        UserAuthenticator.signIn(emailTextField.text, password: passwordTextField.text) { result in
            switch result {
            case .Success:
                let message = "Logged in as \(result.value?.username)"
                self.alertWithTitle("Success!", message: message)
            case .Failure:
                let message = result.error?.userInfo?["error"] as? String
                self.alertWithTitle("Error", message: message)
            }
        }
    }
    
    func alertWithTitle(title: String, message: String?) {
        let errorMessage = message ?? "An unknown error has occured"
        UIAlertView(title: title, message: errorMessage, delegate: nil, cancelButtonTitle: "OK").show()
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
