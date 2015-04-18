//
//  PFQuery.swift
//  Secrets
//
//  Created by James Craige on 4/17/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import Parse
import PromiseKit

extension PFQuery {
    func findObjectsInBackgroundPromise<T: Modelable>() -> Promise<[T]>{
        return Promise<[T]> { (resolve, reject) in
            self.findObjectsInBackgroundWithBlock() { (objects: [AnyObject]?, error: NSError?) in
                if let err = error {
                    reject(err)
                } else {
                    if let objects = objects as? [PFObject] {
                        let comments = objects.map { T(object: $0) }
                        resolve(comments)
                    }
                }
            }
        }
    }
}
