//
//  AuthenticationViewController.swift
//  Secrets
//
//  Created by James Craige on 4/10/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController {
    func presentMainFlow() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        
        if let vc = mainStoryboard.instantiateInitialViewController() as? UINavigationController {
            presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    func alertWithTitle(title: String, message: String?) {
        let errorMessage = message ?? "An unknown error has occured"
        UIAlertView(title: title, message: errorMessage, delegate: nil, cancelButtonTitle: "OK").show()
    }
}
