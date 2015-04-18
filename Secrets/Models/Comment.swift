//
//  Comment.swift
//  Secrets
//
//  Created by James Craige on 4/17/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import Parse
import PromiseKit

class Comment: Modelable {
    let object: PFObject
    
    required init(object: PFObject) {
        self.object = object
    }
    
    class func createWithBody(body: String, secret: Secret) -> Promise<Void> {
        let comment = PFObject(className: "Comment")
        comment["body"] = body
        comment["parent"] = secret.object
        return comment.saveInBackgroundPromise()
    }
    
    class func whereSecretIs(secret: Secret) -> Promise<[Comment]> {
        var query = PFQuery(className: "Comment")
        query.whereKey("parent", equalTo: secret.object)
        return query.findObjectsInBackgroundPromise()
    }
    
    var body: String? {
        return object["body"] as? String
    }
}