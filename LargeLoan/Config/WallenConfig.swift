//
//  TwoConfig.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/28.
//

import UIKit
import DeviceKit
import Alamofire
import SystemConfiguration.CaptiveNetwork

class CurrentTimeManager {
    static func getCurrentTime() -> String {
        let currentTime = Date().timeIntervalSince1970
        let currentTimeMillis = String(Int64(currentTime * 1000))
        return currentTimeMillis
    }
}

class TwoPastManager {
    
    static func getMacInfo() -> String {
        guard let interfaces = CNCopySupportedInterfaces() as? [String] else {
            return ""
        }
        for interface in interfaces {
            guard let networkInfo = CNCopyCurrentNetworkInfo(interface as CFString) as? [String: Any],
                  let bssid = networkInfo[kCNNetworkInfoKeyBSSID as String] as? String else {
                continue
            }
            return bssid
        }
        return ""
    }
    
    static func getCurrentTime() -> String {
        let currentTime = Date().timeIntervalSince1970
        let currentTimeMillis = String(Int64(currentTime * 1000))
        return currentTimeMillis
    }
    
    static func isProxy() -> String {
        guard let proxySettings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [AnyHashable: Any] else {
            return "0"
        }
        let testURL = URL(string: "https://www.apple.com")!
        guard let proxies = CFNetworkCopyProxiesForURL(testURL as CFURL, proxySettings as CFDictionary).takeRetainedValue() as? [[AnyHashable: Any]] else {
            return "0"
        }
        guard let proxyType = proxies.first?[kCFProxyTypeKey] as? String else {
            return "0"
        }
        return proxyType == kCFProxyTypeNone as String ? "0" : "1"
    }
    
    static func isVPN() -> Bool {
        var zeroAddress = sockaddr()
        zeroAddress.sa_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sa_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }) else {
            return false
        }
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return isReachable && !needsConnection
    }
    
    static func isBreak() -> String {
        let jailbreakToolPaths = [
            "/Applications/Cydia.app",
            "/bin/bash",
            "/usr/sbin/sshd",
            "/usr/sbin/sshd",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
        ]
        for path in jailbreakToolPaths {
            if FileManager.default.fileExists(atPath: path) {
                return "1"
            }
        }
        return "0"
    }
    
    static func getDeviceLanguage() -> String {
        let languageCode = Locale.current.languageCode ?? "en"
        return languageCode
    }
    
    static func getWifiName() -> String {
        var wifiInfo: String = "NONE"
        let reachabilityManager = NetworkReachabilityManager()
        let status = reachabilityManager?.status
        if status == .notReachable {
            wifiInfo = "NONE"
        } else if status == .reachable(.cellular) {
            wifiInfo = "5G/4G"
        } else if status == .reachable(.ethernetOrWiFi) {
            wifiInfo = "WIFI"
        }else {
            wifiInfo = "NONE"
        }
        return wifiInfo
    }
    
    static func timeStart() -> String {
        let systemUptime = ProcessInfo.processInfo.systemUptime
        return String(format: "%.0f", systemUptime * 1000)
    }
    
    let former = GetIdfv.getIDFV()
    let gathering = GetIdfa.getIDFA()
    let frontier = getMacInfo()
    let guarding = getCurrentTime()
    let cavalry = isProxy()
    let troops = isVPN()
    let battlefield = isBreak()
    let your: String = Device.current.isSimulator ? "1" : "0"
    let implicate = getDeviceLanguage()
    let does = ""
    let enemies = getWifiName()
    let being = NSTimeZone.system.abbreviation() ?? ""
    let dreams = timeStart()
    
    func getTwoInfo() -> [String: Any] {
        var twoInfo: [String: Any] = [:]
        twoInfo["resisting"] = ["former": former,
                                "gathering": gathering,
                                "frontier": frontier,
                                "guarding": guarding,
                                "cavalry": cavalry,
                                "troops": troops,
                                "battlefield": battlefield,
                                "your": your,
                                "implicate": implicate,
                                "does": does,
                                "enemies": enemies,
                                "being": being,
                                "dreams": dreams]
        return twoInfo
    }
}
