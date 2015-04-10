import UIKit
import Parse

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        let testObject = PFObject(className: "TestObject2")
        testObject["fooz"] = "bar"
        testObject.saveInBackgroundWithBlock() { (success: Bool, error: NSError?) in
            if let err = error {
                println("ERRORRRR")
            } else {
                println("Object saved")
            }
        }
    }
}
