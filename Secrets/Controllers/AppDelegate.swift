import UIKit
import Parse
import Bolts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var pushManager: PushManager?

    // MARK: UIApplicationDelegate
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        initializeParseWithLaunchOptions(launchOptions)
        initializeStoryboard()
        initializePushNotifications(application)

        return true
    }

    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        pushManager?.didRegisterForRemoteNotificationsWithDeviceToken(deviceToken)
    }

    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        pushManager?.didReceiveRemoteNotification(userInfo)
    }

    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        pushManager?.didFailToRegisterForRemoteNotificationsWithError(error)
    }

    // MARK: initializers
    func initializePushNotifications(application: UIApplication) {
        pushManager = PushManager(application: application)
        pushManager?.registerForNotifications()
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
