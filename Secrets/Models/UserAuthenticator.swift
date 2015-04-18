//
//  UserAuthenticator.swift
//  Secrets
//
//  Created by James Craige on 4/10/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//
import Parse
import PromiseKit
import LlamaKit

class UserAuthenticator {
    class func signUp(email: String, password: String) -> Promise<PFUser> {
        var user = PFUser()
        user.username = email
        user.password = password
        return user.signUpInBackgroundPromise()
    }
    
    class func signIn(email: String, password: String) -> Promise<PFUser> {
        return PFUser.logInWithUsernamePromise(email, password: password)
    }

    class func signOut() {
        PFUser.logOut()
    }
}
