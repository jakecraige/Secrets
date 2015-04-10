import UIKit
import Parse
import Bolts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        initializeParseWithLaunchOptions(launchOptions)
        
        let storyboard = UIStoryboard(name: "SignInFlow", bundle: NSBundle.mainBundle())
        let welcomeVc = storyboard.instantiateInitialViewController() as! UINavigationController
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = welcomeVc
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func initializeParseWithLaunchOptions(launchOptions: [NSObject : AnyObject]?) {
        Parse.enableLocalDatastore()
        Parse.setApplicationId(Keys.Parse.applicationId, clientKey: Keys.Parse.clientKey);
        PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground(launchOptions, block: nil)
    }
}
