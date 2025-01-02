//
//  LConig.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/16.
//

import Kingfisher
import DeviceKit
import SAMKeychain
import TYAlertController
import AdSupport

let LargeLoan_one = "LargeLoan_one"
let LargeLoan_two = "LargeLoan_two"

let point = "ios"
let occurred = "1.0.0"
let but = Device.current.description
let narrated = GetIdfv.getIDFV()
let slow = UIDevice.current.systemVersion
let process = "large"
let trembling = narrated
let loveMe = "ture"


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

class GetIdfa {
    static func getIDFA() -> String {
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
}



class GetDengLuConfig {
    
    static func loginConfig() -> [String: String] {
        var nonstop: String = ""
        if let sessionId: String = UserDefaults.standard.object(forKey: LOGIN_TWO) as? String {
            nonstop = sessionId
        }
        
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
    
    static func removeLoginInfo() {
        UserDefaults.standard.setValue("", forKey: LOGIN_ONE)
        UserDefaults.standard.setValue("", forKey: LOGIN_TWO)
        UserDefaults.standard.setValue("", forKey: "CONTINUEONE")
        UserDefaults.standard.synchronize()
    }
}


class ShowalertConfig {
    
    static func alertShow(form view: UIView, vc: BaseViewController, style: TYAlertControllerStyle = .alert ) {
        let alertVc = TYAlertController(alert: view, preferredStyle: style)!
        vc.present(alertVc, animated: true)
    }
    
    static func showSettingsAlert(from viewController: BaseViewController, feature: String) {
        var message: String = ""
        
        if feature == "Contact" {
            message = "To ensure your application is processed smoothly, please enable \"Allow All\" permissions. If you choose to deny or allow partial permissions, it may affect the application review process. Please go to the settings page to adjust the permissions."
        }else if feature == "Camera" {
            message = Bundle.main.object(forInfoDictionaryKey: "NSCameraUsageDescription") as? String ?? ""
        }else if feature == "PhotoLibrary" {
            message = Bundle.main.object(forInfoDictionaryKey: "NSPhotoLibraryUsageDescription") as? String ?? ""
        }else if feature == "Location" {
             message = Bundle.main.object(forInfoDictionaryKey: "NSLocationAlwaysUsageDescription") as? String ?? ""
        }else {
            message = ""
        }
        let alert = UIAlertController(
            title: "\(feature) Permission denied",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Go", style: .default) { _ in
            openSettings()
        })
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func openSettings() {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(settingsURL) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        }
    }
    
}


extension Data {
    
    static func compressImageTo1MB(image: UIImage) -> Data? {
        var compression: CGFloat = 0.8
        var compressedData = image.jpegData(compressionQuality: compression)
        while compressedData?.count ?? 0 > 1_000_000 && compression > 0.1 {
            compression -= 0.1
            compressedData = image.jpegData(compressionQuality: compression)
        }
        
        return compressedData
    }
    
}


class PaddedLabel: UILabel {
    var padding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    
    override func drawText(in rect: CGRect) {
        let paddedRect = rect.inset(by: padding)
        super.drawText(in: paddedRect)
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + padding.left + padding.right,
                      height: size.height + padding.top + padding.bottom)
    }
}
