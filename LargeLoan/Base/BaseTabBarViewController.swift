//
//  BaseTabBarViewController.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/12.
//

import UIKit

class BaseTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TabBar 设置
        tabBar.backgroundColor = .white
        tabBar.isTranslucent = false
        
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.1
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -2)
        tabBar.layer.shadowRadius = 10
        
        let homeVC = HomeViewController()
        let orderVc = OrdersViewController()
        let centerVC = CenterViewController()
        
        homeVC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "homenor")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "homesel")?.withRenderingMode(.alwaysOriginal)
        )
        
        orderVc.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "ordernor")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "ordersel")?.withRenderingMode(.alwaysOriginal)
        )
        
        centerVC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "cennor")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "censel")?.withRenderingMode(.alwaysOriginal)
        )
        
        viewControllers = [
            BaseNavigationController(rootViewController: homeVC),
            BaseNavigationController(rootViewController: orderVc),
            BaseNavigationController(rootViewController: centerVC)
        ]
        
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred()
        guard let selectedItem = tabBarController.tabBar.selectedItem else { return }
        if let selectedView = selectedItem.value(forKey: "view") as? UIView {
            if let imageView = selectedView.subviews.first(where: { $0 is UIImageView }) as? UIImageView {
                let scaleUp = CABasicAnimation(keyPath: "transform.scale")
                scaleUp.fromValue = 1.0
                scaleUp.toValue = 1.2
                scaleUp.duration = 0.2
                scaleUp.autoreverses = true
                scaleUp.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
                imageView.layer.add(scaleUp, forKey: nil)
            }
        }
    }
    
}

extension BaseTabBarViewController {
    
    
}
