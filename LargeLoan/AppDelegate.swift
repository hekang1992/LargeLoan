//
//  AppDelegate.swift
//  LargeLoan
//
//  Created by 何康 on 2024/11/29.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = LoginViewController()
        noti()
        window?.makeKeyAndVisible()
        return true
    }

}

extension AppDelegate {
    
    private func noti() {
        NotificationCenter.default.addObserver(self, selector: #selector(rootVc(_ :)), name: NSNotification.Name(ROOT_VC), object: nil)
    }
    
    @objc private func rootVc(_ notification: Notification) {
        let isLogin = UserDefaults.standard.object(forKey: PHONE_PHONE) as? String ?? ""
        window?.rootViewController = isLogin.isEmpty ? BaseNavigationController(rootViewController: BaseTabBarViewController()) : BaseNavigationController(rootViewController: BaseTabBarViewController())
    }
}
