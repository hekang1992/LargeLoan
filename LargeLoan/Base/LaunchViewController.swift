//
//  ViewController.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/17.
//

import UIKit
import SystemConfiguration.CaptiveNetwork

class LaunchViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        PushRootVcConfig.goRootVc()
    }
    
}

extension LaunchViewController {
    
    private func fcinofnetwordnewyork() {
        NetworkManager.shared.startListening()
    }
}
