
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    
       var window: UIWindow?

       func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
           
           self.window = UIWindow()
           self.window?.frame = UIScreen.main.bounds
           self.window?.rootViewController = ViewController.init()
           self.window?.makeKeyAndVisible()
           
           return true
       }


}

