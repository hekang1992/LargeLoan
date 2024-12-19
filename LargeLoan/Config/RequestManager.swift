//
//  RequestManager.swift
//  LargeLoan
//
//  Created by 何康 on 2024/11/29.
//

import Moya
import Alamofire

let h5Host = "http://8.212.181.184:8493"
let apiHost = "http://8.212.181.184:8493/largeloanapi"
let urlScheme =  "large://how.big.app"

enum LargeLoanAPI {
    case tocode(phone: String)
    case tologin(phone: String, code: String)
    case tologOut
    case todeleinfo
    case toHomeData
    case applyInfo(productId: String)
    case productDetailInfo(productId: String)
    case southern(old: String)
}

extension LargeLoanAPI: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: apiHost) else { fatalError("InvalidURL")
        }
        let config = GetDengLuConfig.loginConfig()
        let apiUrl = DictToString.appendters(url: url.absoluteString, parameters: config) ?? ""
        return URL(string: apiUrl)!
    }
    
    var method: Moya.Method {
        switch self {
        case .tocode, .tologin, .applyInfo, .productDetailInfo:
            return .post
        case .tologOut, .todeleinfo, .toHomeData, .southern:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .tocode(phone: let phone):
            return .requestParameters(parameters: ["shall": phone, "type": "code"], encoding: URLEncoding.default)
        case .tologin(phone: let surroundings, code: let surveyed):
            return .requestParameters(parameters: ["surroundings": surroundings, "surveyed": surveyed, "type": "login"], encoding: URLEncoding.default)
        case .tologOut:
            return .requestParameters(parameters: [String: Any](), encoding: URLEncoding.default)
        case .todeleinfo:
            return .requestParameters(parameters: [String: Any](), encoding: URLEncoding.default)
        case .toHomeData:
            return .requestParameters(parameters: [String: Any](), encoding: URLEncoding.default)
        case .applyInfo(productId: let productId):
            return .requestParameters(parameters: ["old": productId, "thirty": "30", "type": "apply"], encoding: URLEncoding.default)
        case .productDetailInfo(productId: let productId):
            return .requestParameters(parameters: ["old": productId, "whispers": "10", "type": "productDetailInfo"], encoding: URLEncoding.default)
        case .southern(old: let old):
            return .requestParameters(parameters: ["old": old, "knew": "y1", "type": "allow"], encoding: URLEncoding.default)
        }
        
    }
    
    var headers: [String: String]? {
        return [
            "Accept": "application/json",
            "Connection": "keep-alive",
            "Content-Type": "application/x-www-form-urlencoded;multipart/form-data"
        ]
    }
    
    var path: String {
        switch self {
        case .tocode(_):
            return "/allow/embroiled"
        case .tologin(_, _):
            return "/allow/hunting"
        case .tologOut:
            return "/allow/while"
        case .todeleinfo:
            return "/allow/hands"
        case .toHomeData:
            return "/allow/wolves"
        case .applyInfo:
            return "/allow/unkempt"
        case .productDetailInfo:
            return "/allow/earlier"
        case .southern:
            return "/allow/southern"
        }
        
    }
    
}


class DictToString {
    
    static func appendters(url: String, parameters: [String: String]) -> String? {
        guard var urlComponents = URLComponents(string: url) else {
            return nil
        }
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        return urlComponents.url?.absoluteString
    }
    
}
