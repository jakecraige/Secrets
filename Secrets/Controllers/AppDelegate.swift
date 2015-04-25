import UIKit
import Parse
import Bolts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    // MARK: UIApplicationDelegate
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        initializeParseWithLaunchOptions(launchOptions)
        initializeStoryboard()
        initializePushNotifications(application)

        return true
    }

    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let installation = PFInstallation.currentInstallation()
        installation.setDeviceTokenFromData(deviceToken)
        installation.channels = ["global"]
        installation["user"] = PFUser.currentUser()
        installation.saveInBackgroundPromise().then { _ in
            println("Installation saved for device token: \(deviceToken)")
        }
    }

    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        PFPush.handlePush(userInfo)
    }

    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        if error.code == 3010 {
            println("Push notifications are not supported in the iOS Simulator.")
        } else {
            println("application:didFailToRegisterForRemoteNotificationsWithError: %@", error)
        }
    }

    // MARK: initializers
    func initializePushNotifications(application: UIApplication) {
        let notificationTypes = UIUserNotificationType.Alert
        let settings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
        application.registerUserNotificationSettings(settings)
        application.registerForRemoteNotifications()
    }

    func initializeStoryboard() {
        var storyboardName = "Authentication"
        if let user = PFUser.currentUser() {
            storyboardName = "Main"
        }
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: NSBundle.mainBundle())
        let rootVC = storyboard.instantiateInitialViewController() as! UINavigationController
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
    }

    func initializeParseWithLaunchOptions(launchOptions: [NSObject : AnyObject]?) {
        Parse.enableLocalDatastore()
        Parse.setApplicationId(Keys.Parse.applicationId, clientKey: Keys.Parse.clientKey);
        PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground(launchOptions, block: nil)
    }
}
