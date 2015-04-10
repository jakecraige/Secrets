//
//  UserAuthenticator.swift
//  Secrets
//
//  Created by James Craige on 4/10/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//
import Parse
import LlamaKit

typealias ErrorMessage = String

class UserAuthenticator {
    class func signUp(email: String, password: String, block: Result<Bool, NSError> -> Void) {
        var user = PFUser()
        user.username = email
        user.password = password
        user.signUpInBackgroundWithBlock() { (succeeded: Bool, error: NSError?) in
            if let err = error {
                block(failure(err))
            } else {
                block(success(succeeded))
            }
        }
    }
    
    class func signIn(email: String, password: String, block: Result<PFUser, NSError> -> Void) {
        PFUser.logInWithUsernameInBackground(email, password: password) { (user: PFUser?, error: NSError?) in
            if let err = error {
                block(failure(err))
            } else {
                block(success(user!))
            }
        }
    }
}
