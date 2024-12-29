//
//  Networkmanager.swift
//  LargeLoan
//
//  Created by 何康 on 2024/12/28.
//

import Alamofire
import AppTrackingTransparency
import Moya

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
                break
            case .reachable(.ethernetOrWiFi):
                self.uvinfo()
                break
            case .reachable(.cellular):
                self.uvinfo()
                break
            case .unknown:
                break
            }
        })
    }
    
    func stopListening() {
        self.reachabilityManager?.stopListening()
    }
    
    
    func uvinfo() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if #available(iOS 14.0, *) {
                ATTrackingManager.requestTrackingAuthorization { status in
                    switch status {
                    case .restricted:
                        break
                    case .authorized, .notDetermined, .denied:
                        self.uploidfainfo()
                        break
                    @unknown default:
                        break
                    }
                }
            }
        }
    }
    
    private func uploidfainfo() {
        let provider = MoyaProvider<LargeLoanAPI>()
        let former = GetIdfv.getIDFV()
        let gathering = GetIdfa.getIDFA()
        let dict = ["pretense": "av",
                    "former": former,
                    "gathering": gathering]
        provider.request(.soundsInfo(emptyDict: dict)) { result in
            switch result {
            case .success(_):
                break
            case .failure(_):
                break
            }
        }
        
    }
}


