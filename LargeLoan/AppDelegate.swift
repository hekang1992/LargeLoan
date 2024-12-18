//
//  AppDelegate.swift
//  LargeLoan
//
//  Created by 何康 on 2024/11/29.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController()
        NotificationCenter.default.addObserver(self, selector: #selector(rootVc(_ :)), name: NSNotification.Name(ROOT_VC), object: nil)
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.enable = true
        window?.makeKeyAndVisible()
        return true
    }

}

extension AppDelegate {
    
    @objc private func rootVc(_ notification: Notification) {
        let isLogin = UserDefaults.standard.object(forKey: LOGIN_TWO) as? String ?? ""
        window?.rootViewController = isLogin.isEmpty ? BaseNavigationController(rootViewController: LoginViewController()) : BaseNavigationController(rootViewController: BaseTabBarViewController())
    }
}
