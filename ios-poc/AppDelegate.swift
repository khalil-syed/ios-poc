//Created on 6/4/20

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        guard normalExecutionPath() else {
            self.window = nil
            return true
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: CountryInfoRouter.createModule())
        window?.makeKeyAndVisible()
        return true
    }
    
    private func normalExecutionPath() -> Bool {
        return NSClassFromString("XCTestCase") == nil
    }

}

