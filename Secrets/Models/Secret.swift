//
//  Secret.swift
//  Secrets
//
//  Created by James Craige on 4/10/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import Parse
import LlamaKit

class Secret {
    class func find(block: Result<[PFObject], NSError> -> Void) {
        let query = PFQuery(className: "Secret")
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock() { (objects: [AnyObject]?, error: NSError?) in
            if let err = error {
                block(failure(err))
            } else {
                println("Successfully retrieved \(objects!.count) scores.")
                if let objects = objects as? [PFObject] {
                    block(success(objects))
                }
            }
        }
    }
}