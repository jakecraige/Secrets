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

    var user: PFUser? {
        return object["user"] as? PFUser
    }

    var currentUsersSecret: Bool {
        return PFUser.currentUser() != object["user"] as? PFUser
    }

    func addHeart() {
        self.object.incrementKey("hearts")
    }
    
    func saveEventually() {
        object.saveEventually()
    }

    func registerForCreatorChannel() -> Promise<Void> {
        if let pm = pushManager {
            return pm.registerForChannel(creatorChannel)
        } else {
            return Promise(value: Void())
        }
    }

    func sendNewCommentNotificationToCreator(comment: Comment) {
        if self.user != comment.user {
            let msg = commentNotificationMessage(comment)
            pushManager?.sendNotificationToChannel(creatorChannel, message: msg)
        }
    }

    private func commentNotificationMessage(comment: Comment) -> String {
        let body = comment.body ?? ""
        return "New comment on your secret: \"\(body)\""
    }

    private var pushManager: PushManager? {
        return (UIApplication.sharedApplication().delegate as? AppDelegate)?.pushManager
    }
}