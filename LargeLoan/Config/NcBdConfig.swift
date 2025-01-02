//
//  SixConfig.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/28.
//

import SystemServices

import Foundation

class SystemDiskInfo {
    static func freeDiskSpace() -> String {
        formatSize(SystemServices.shared().longFreeDiskSpace)
    }
    
    static func totalDiskSpace() -> String {
        formatSize(SystemServices.shared().longDiskSpace)
    }
    
    static func totalMemory() -> String {
        formatSize(Int64(SystemServices.shared().totalMemory) * 1024 * 1024)
    }
    
    static func activeMemory() -> String {
        formatSize(Int64(SystemServices.shared().activeMemoryinRaw * 1024) * 1024)
    }
    
    func systemSummary() -> [String: Any] {
        return [
            "each": [
                "stage": SystemDiskInfo.freeDiskSpace(),
                "come": SystemDiskInfo.totalDiskSpace(),
                "things": SystemDiskInfo.totalMemory(),
                "keep": SystemDiskInfo.activeMemory()
            ]
        ]
    }
    
    private static func formatSize(_ size: Int64) -> String {
        let sizeInGB = Double(size)
        return String(format: "%.0f", sizeInGB)
    }
}


class GetDAllInfo {
    
    static func getAllInfo() -> [String: Any] {
        
        let managers: [Any] = [
            OnePastManager(),
            TwoPastManager(),
            ThreePastManager(),
            FourPastManager(),
            SystemDiskInfo()
        ]
        let result = managers.reduce(into: [String: Any]()) { dict, manager in
            if let oneManager = manager as? OnePastManager {
                dict.merge(oneManager.getOneInfo()) { current, _ in current }
            } else if let twoManager = manager as? TwoPastManager {
                dict.merge(twoManager.getTwoInfo()) { current, _ in current }
            } else if let threeManager = manager as? ThreePastManager {
                dict.merge(threeManager.getThreeInfo()) { current, _ in current }
            } else if let fourManager = manager as? FourPastManager {
                dict.merge(fourManager.getFourInfo()) { current, _ in current }
            } else if let systemDiskInfo = manager as? SystemDiskInfo {
                dict.merge(systemDiskInfo.systemSummary()) { current, _ in current }
            }
        }
        
        return result
    }
    
}
