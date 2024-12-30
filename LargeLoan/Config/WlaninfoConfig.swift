//
//  FourConfig.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/28.
//

import UIKit
import SystemServices
import SystemConfiguration.CaptiveNetwork

struct WiFi: Codable {
    let bed: String
    let mu: String
    let frontier: String
    let father: String
}

struct Softly: Codable {
    let wuding: String
    var lord: [WiFi]
    let sigh: WiFi
    var giving: Int {
        return lord.count
    }
}

class FourPastManager {
    static func getbssid() -> String {
        guard let interfaces = CNCopySupportedInterfaces() as? [String],
              let interface = interfaces.first as CFString?,
              let networkInfo = CNCopyCurrentNetworkInfo(interface) as? [String: Any],
              let ssid = networkInfo["SSID"] as? String else {
            return ""
        }
        return ssid
    }
    
    func getFourInfo() -> [String: Any] {
        let ipAddress = SSNetworkInfo.currentIPAddress() ?? ""
        let sighWiFi = WiFi(
            bed: FourPastManager.getbssid(),
            mu: TwoPastManager.getMacInfo(),
            frontier: TwoPastManager.getMacInfo(),
            father: FourPastManager.getbssid()
        )
        let lordWiFiArray = [WiFi(bed: FourPastManager.getbssid(),
                                  mu: TwoPastManager.getMacInfo(),
                                  frontier: TwoPastManager.getMacInfo(),
                                  father: FourPastManager.getbssid())]
        let softly = Softly(
            wuding: ipAddress,
            lord: lordWiFiArray,
            sigh: sighWiFi
        )
        
        do {
            let jsonData = try JSONEncoder().encode(softly)
            if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                return jsonObject
            }
        } catch {
            print("dictionary: \(error)")
        }
        return [:]
        
    }
}


