//
//  Secret.swift
//  Secrets
//
//  Created by James Craige on 4/10/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import Parse
import PromiseKit

class Secret: Modelable {
    class func find() -> Promise<[Secret]> {
        let query = PFQuery(className: "Secret")
        query.orderByDescending("createdAt")
        return query.findObjectsInBackgroundPromise()
    }
    
    class func createWithBody(body: String) -> Promise<Void> {
        var newSecret = PFObject(className: "Secret")
        newSecret["body"] = body
        newSecret["user"] = PFUser.currentUser()

        return LocationManager.currentNeighborhood().then { neighborhood in
            newSecret["neighborhood"] = neighborhood;
        }.finally {
            return newSecret.saveInBackgroundPromise().then { _ -> Promise<Void> in
                let secret = Secret(object: newSecret)
                return secret.registerForCreatorChannel()
            }
        }
    }
    
    let object: PFObject
    
    required init(object: PFObject) {
        self.object = object
    }
    
    var body: String? {
        return object["body"] as? String
    }

    var neighborhood: String? {
        return object["neighborhood"] as? String
    }
    
    var createdAt: NSDate? {
        return object.createdAt
    }
    
    var hearts: Int {
        return object["hearts"] as? Int ?? 0
    }

    var creatorChannel: String? {
        if let objectId = object.objectId {
             return "secret-\(objectId)-channel"
        } else {
            return nil
        }
    }
    
    func addHeart() {
        self.object.incrementKey("hearts")
    }
    
    func saveEventually() {
        object.saveEventually()
    }

    func registerForCreatorChannel() -> Promise<Void> {
        if let pushManager = (UIApplication.sharedApplication().delegate as? AppDelegate)?.pushManager {

            return pushManager.registerForChannel(creatorChannel)
        } else {
            return Promise(value: Void())
        }
    }
}