//
//  PFObject.swift
//  Secrets
//
//  Created by James Craige on 4/17/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import Parse
import PromiseKit

extension PFObject {
    func saveInBackgroundPromise() -> Promise<Void> {
        return Promise<Void> { (resolve, reject) in
            self.saveInBackgroundWithBlock() { (succeeded: Bool, error: NSError?) in
                if let err = error {
                    reject(err)
                } else {
                    resolve()
                }
            }
        }
    }
}