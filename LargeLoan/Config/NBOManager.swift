//
//  NBOManager.swift
//  LargeLoan
//
//  Created by 何康 on 2024/12/28.
//

import UIKit
import Alamofire

class onePastManager {
    
    func getOSInfo() -> [String: String] {
        
        let osVersion = UIDevice.current.systemVersion
        let osType = "ios"
        return ["wars": osType, "pains": osVersion]
    }
    
    func getLastLoginTime() -> [String: Any] {
        let lasttime = ProcessInfo.processInfo.systemUptime
        let loginDate = Date(timeIntervalSinceNow: -lasttime)
        let loginTime = String(format: "%ld", Int(loginDate.timeIntervalSince1970 * 1000))
        return ["spared": loginTime]
    }
    
    func getAppInfo() -> [String: String] {
        let bundleID = Bundle.main.bundleIdentifier ?? "Unknown"
        return ["place": bundleID]
    }
    
    func getBatteryInfo() -> [String: Any] {
        UIDevice.current.isBatteryMonitoringEnabled = true
        let batteryLevel = Int(UIDevice.current.batteryLevel * 100)
        let isCharging = UIDevice.current.batteryState == .charging ? 1 : 0
        return [
            "protect": [
                "vow": batteryLevel,
                "general": isCharging
            ]
        ]
    }
    
    func getoneDetails() -> [String: Any] {
        var deviceInfo: [String: Any] = [:]
        deviceInfo.merge(getOSInfo()) { (current, _) in current }
        deviceInfo.merge(getLastLoginTime()) { (current, _) in current }
        deviceInfo.merge(getAppInfo()) { (current, _) in current }
        deviceInfo.merge(getBatteryInfo()) { (current, _) in current }
        return deviceInfo
    }
    
}

class TwoPastManager {
    
}

class ThreePastManager {
    
}

class NetworkManager {
    
    static let shared = NetworkManager()
    private var reachabilityManager: NetworkReachabilityManager?
    
    private init() {
        self.reachabilityManager = NetworkReachabilityManager()
    }
    
    func startListening() {
        self.reachabilityManager?.startListening(onUpdatePerforming: { status in
            switch status {
            case .notReachable:
                print("Network is not reachable.")
            case .reachable(.ethernetOrWiFi):
                print("Network is reachable via WiFi.")
            case .reachable(.cellular):
                print("Network is reachable via Cellular.")
            case .unknown:
                print("Network status is unknown.")
            }
        })
    }
    
    func stopListening() {
        self.reachabilityManager?.stopListening()
    }
}


