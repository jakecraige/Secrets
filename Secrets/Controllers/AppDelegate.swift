import UIKit
import Parse
import Bolts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        initializeParseWithLaunchOptions(launchOptions)
        return true
    }
    
    func initializeParseWithLaunchOptions(launchOptions: [NSObject : AnyObject]?) {
        Parse.enableLocalDatastore()
        Parse.setApplicationId(Keys.Parse.applicationId, clientKey: Keys.Parse.clientKey);
        PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground(launchOptions, block: nil)
    }
}
