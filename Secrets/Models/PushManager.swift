//
//  PushManager.swift
//  Secrets
//
//  Created by James Craige on 5/1/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import UIKit
import Parse
import PromiseKit

class PushManager {
    let installation: PFInstallation
    let application: UIApplication

    init(application: UIApplication) {
        self.installation = PFInstallation.currentInstallation()
        self.application = application
    }

    func registerForNotifications() {
        let notificationTypes = UIUserNotificationType.Alert
        let settings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
        application.registerUserNotificationSettings(settings)
        application.registerForRemoteNotifications()
    }

    func didRegisterForRemoteNotificationsWithDeviceToken(deviceToken: NSData) {
        installation.setDeviceTokenFromData(deviceToken)
        if installation.channels?.count == 0 {
            installation.channels = ["global"]
        }
        installation["user"] = PFUser.currentUser()
        installation.saveInBackgroundPromise()
    }

    func didReceiveRemoteNotification(userInfo: [NSObject : AnyObject]) {
        PFPush.handlePush(userInfo)
    }

    func didFailToRegisterForRemoteNotificationsWithError(error: NSError) {
        if error.code == 3010 {
            println("Push notifications are not supported in the iOS Simulator.")
        } else {
            println("application:didFailToRegisterForRemoteNotificationsWithError: %@", error)
        }
    }

    func registerForChannel(channel: String?) -> Promise<Void> {
        if let chan = channel {
            installation.addUniqueObject(chan, forKey: "channels")
            return installation.saveInBackgroundPromise()
        } else {
            return Promise(value: Void())
        }
    }

    func sendNotificationToChannel(channel: String?, message: String) {
        if let chan = channel {
            let push = PFPush()
            push.setChannel(chan)
            push.setMessage(message)
            push.sendPushInBackground()
            println("send push to \(chan) with message \(message)")
        }
    }
}