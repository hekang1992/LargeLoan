//
//  LConig.swift
//  LargeLoan
//
//  Created by 何康 on 2024/12/16.
//

import DeviceKit
import SAMKeychain

let LargeLoan_one = "LargeLoan_one"
let LargeLoan_two = "LargeLoan_two"

let point = "ios"
let occurred = "1.0.0"
let but = Device.current.description
let narrated = GetIdfv.getIDFV()
let slow = UIDevice.current.systemVersion
let process = "large"
let nonstop = UserDefaults.standard.object(forKey: LOGIN_TWO) as? String ?? ""
let trembling = narrated
let loveMe = "ture"

let loginConfig = GetDengLuConfig.loginConfig()

class GetIdfv {
    static func getIDFV() -> String {
        if let uuid = SAMKeychain.password(forService: LargeLoan_one, account: LargeLoan_two), !uuid.isEmpty {
            return uuid
        }
        guard let deviceIDFV = UIDevice.current.identifierForVendor?.uuidString else {
            return ""
        }
        let isSuccess = SAMKeychain.setPassword(deviceIDFV, forService: LargeLoan_one, account: LargeLoan_two)
        return isSuccess ? deviceIDFV : ""
    }
    
}


class GetDengLuConfig {
    
    static func loginConfig() -> [String: String] {
        let onedict = ["point": point,
                       "process": process,
                       "nonstop": nonstop]
        let twodict = ["occurred": occurred,
                       "slow": slow,
                       "trembling": trembling]
        let threedict = ["but": but,
                         "narrated": narrated,
                         "loveMe": loveMe]
        
        
        var fourDict = onedict
        fourDict.merge(twodict) { (current, _) in current }
        
        var allDict = fourDict
        threedict.forEach { key, value in
            allDict[key] = value
        }
        
        return allDict
        
    }
    
    
}


class ToastConfig {
    static func show(form view: UIView, message: String) {
        view.makeToast(message, duration: 2.0, position: .center)
    }
}


let LOGIN_ONE = "LOGIN_ONE"
let LOGIN_TWO = "LOGIN_TWO"

class LoginFactory {
    
    static func saveLoginInfo(one: String, two: String) {
        UserDefaults.standard.setValue(one, forKey: LOGIN_ONE)
        UserDefaults.standard.setValue(two, forKey: LOGIN_TWO)
        UserDefaults.standard.synchronize()
    }
    
    static func removeLoginInfo(one: String, two: String) {
        UserDefaults.standard.setValue("", forKey: LOGIN_ONE)
        UserDefaults.standard.setValue("", forKey: LOGIN_TWO)
        UserDefaults.standard.synchronize()
    }
}
