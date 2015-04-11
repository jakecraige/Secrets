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
    class func find(block: Result<[Secret], NSError> -> Void) {
        let query = PFQuery(className: "Secret")
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock() { (objects: [AnyObject]?, error: NSError?) in
            if let err = error {
                block(failure(err))
            } else {
                if let objects = objects as? [PFObject] {
                    let secrets = objects.map { Secret(object: $0) }
                    block(success(secrets))
                }
            }
        }
    }
    
    class func createWithBodyInBackgroundWithBlock(body: String, block: Result<Secret, NSError> -> Void) {
        var newSecret = PFObject(className: "Secret")
        newSecret["body"] = body
        let secret = Secret(object: newSecret)
        
        secret.saveInBackgroundWithBlock(block)
    }
    
    let object: PFObject
    
    init(object: PFObject) {
        self.object = object
    }
    
    var body: String? {
        return object["body"] as? String
    }
    var createdAt: NSDate? {
        return object.createdAt
    }
    
    var hearts: Int {
        return object["hearts"] as? Int ?? 0
    }
    
    func addHeart() {
        self.object.incrementKey("hearts")
    }
    
    func saveEventually() {
        object.saveEventually()
    }
    
    func saveInBackgroundWithBlock(block: Result<Secret, NSError> -> Void) {
        object.saveInBackgroundWithBlock() { (succeeded: Bool, error: NSError?) in
            if let err = error {
                block(failure(err))
            } else {
                block(success(self))
            }
        }
    }
}