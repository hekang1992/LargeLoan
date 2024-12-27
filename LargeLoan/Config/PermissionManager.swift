//
//  PermissionManager.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/22.
//

import UIKit
import AVFoundation
import Photos

class PermissionManager {
    
    class func checkCameraPermission(from viewController: BaseViewController, completion: @escaping (Bool) -> Void) {
        let cameraStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch cameraStatus {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    if granted {
                        completion(true)
                    }else {
                        ShowalertConfig.showSettingsAlert(from: viewController, feature: "Camera")
                        completion(false)
                    }
                }
            }
        case .authorized:
            completion(true)
        case .denied, .restricted:
            DispatchQueue.main.async {
                ShowalertConfig.showSettingsAlert(from: viewController, feature: "Camera")
                completion(false)
            }
        @unknown default:
            completion(false)
        }
    }
    
    // MARK: - 检查相册权限
    class func checkPhotoLibraryPermission(from viewController: BaseViewController, completion: @escaping (Bool) -> Void) {
        let photoStatus = PHPhotoLibrary.authorizationStatus()
        switch photoStatus {
        case .notDetermined:
            // 请求权限
            PHPhotoLibrary.requestAuthorization { status in
                DispatchQueue.main.async {
                    if status == .authorized || status == .limited {
                        completion(true)
                    } else {
                        ShowalertConfig.showSettingsAlert(from: viewController, feature: "PhotoLibrary")
                        completion(false)
                    }
                }
            }
        case .authorized, .limited:
            // 已授权
            completion(true)
        case .denied, .restricted:
            // 权限被拒绝，显示提示
            DispatchQueue.main.async {
                ShowalertConfig.showSettingsAlert(from: viewController, feature: "相册")
                completion(false)
            }
        @unknown default:
            completion(false)
        }
    }
    
}
