import UIKit
import Parse
import Bolts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        initializeParseWithLaunchOptions(launchOptions)
        
        var storyboardName = "Authentication"
        if let user = PFUser.currentUser() {
            storyboardName = "Main"
        }

        let storyboard = UIStoryboard(name: storyboardName, bundle: NSBundle.mainBundle())
        let rootVC = storyboard.instantiateInitialViewController() as! UINavigationController
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func initializeParseWithLaunchOptions(launchOptions: [NSObject : AnyObject]?) {
        Parse.enableLocalDatastore()
        Parse.setApplicationId(Keys.Parse.applicationId, clientKey: Keys.Parse.clientKey);
        PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground(launchOptions, block: nil)
    }
}
