//
//  Untitled.swift
//  LargeLoan
//
//  Created by 何康 on 2024/12/28.
//

import UIKit
import SystemServices
import SystemConfiguration.CaptiveNetwork
import DeviceKit

class ThreePastManager {
    
    func getThreeInfo() -> [String: Any] {
        let device = UIDevice.current
        let physicalSize = String(Device.current.diagonal)
        var deviceInfo: [String: Any] = [:]
        deviceInfo["rapacious"] = ""
        deviceInfo["has"] = device.name
        deviceInfo["sighed"] = ""
        deviceInfo["saw"] = String(format: "%.0f", SCREEN_HEIGHT)
        deviceInfo["upon"] = device.name
        deviceInfo["tianwu"] = String(format: "%.0f", SCREEN_WIDTH)
        deviceInfo["luo"] = device.model
        deviceInfo["shocked"] = physicalSize
        deviceInfo["alarmed"] = device.systemVersion
        return deviceInfo
    }
    
}

