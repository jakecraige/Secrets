//
//  PFUser.swift
//  Secrets
//
//  Created by James Craige on 4/17/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import Parse
import PromiseKit

extension PFUser {
    class func logInWithUsernamePromise(email: String, password: String) -> Promise<PFUser> {
        return Promise<PFUser> { (resolve, reject) in
            PFUser.logInWithUsernameInBackground(email, password: password) { (user: PFUser?, error: NSError?) in
                if let err = error {
                    reject(err)
                } else {
                    resolve(user!)
                }
            }
        }
    }
    
    func signUpInBackgroundPromise() -> Promise<PFUser> {
        let defer = Promise<PFUser>.defer()
        
        self.signUpInBackgroundWithBlock() { (user: PFUser?, error: NSError?) in
            if let err = error {
                defer.reject(err)
            } else {
                defer.fulfill(user!)
            }
        }
        
        return defer.promise;
    }
}