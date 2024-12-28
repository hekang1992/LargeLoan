//
//  RequestManager.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/11/29.
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
    case uploadPhotoImage(dict: [String: Any], difficult: Data)
    case saveNameInfo(old: String, name: String, num: String, date: String, defeated: String)
    case getTwoInfo(old: String)
    case getRegion
    case saveTPinfo(emptyDict: [String: Any])
    case getTttInfo(old: String)
    case saveTtPinfo(emptyDict: [String: Any])
    case getlululemonInfo(old: String)
    case savelululemoninfo(emptyDict: [String: Any])
    case uploadPhoneInfo(emptyDict: [String: Any])
    case savePPoneInfo(emptyDict: [String: Any])
    case hqGoldenInfo(sparring: String, mistake: String)
    case saveGoldenInfo(emptyDict: [String: Any])
    case tonexturl(emptyDict: [String: Any])
    case getOListInfo(emptyDict: [String: Any])
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
        case .tocode,
                .tologin,
                .applyInfo,
                .productDetailInfo,
                .uploadPhotoImage,
                .saveNameInfo,
                .getTwoInfo,
                .saveTPinfo,
                .getTttInfo,
                .saveTtPinfo,
                .getlululemonInfo,
                .savelululemoninfo,
                .uploadPhoneInfo,
                .savePPoneInfo,
                .saveGoldenInfo,
                .tonexturl,
                .getOListInfo
            :
            return .post
        case .tologOut,
                .todeleinfo,
                .toHomeData,
                .southern,
                .getRegion,
                .hqGoldenInfo
            :
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .tocode(phone: let phone):
            return .requestParameters(parameters: ["shall": phone,
                                                   "type": "code"],
                                      encoding: URLEncoding.default)
            
        case .tologin(phone: let surroundings, code: let surveyed):
            return .requestParameters(parameters: ["surroundings": surroundings,
                                                   "surveyed": surveyed,
                                                   "type": "login"],
                                      encoding: URLEncoding.default)
            
        case .tologOut, .getRegion, .todeleinfo, .toHomeData:
            return .requestParameters(parameters: [String: Any](),
                                      encoding: URLEncoding.default)
            
        case .applyInfo(productId: let productId):
            return .requestParameters(parameters: ["old": productId,
                                                   "thirty": "30",
                                                   "type": "apply"],
                                      encoding: URLEncoding.default)
            
        case .productDetailInfo(productId: let productId):
            return .requestParameters(parameters: ["old": productId,
                                                   "whispers": "10",
                                                   "type": "productDetailInfo"],
                                      encoding: URLEncoding.default)
            
        case .southern(old: let old):
            return .requestParameters(parameters: ["old": old,
                                                   "knew": "y1",
                                                   "type": "allow"],
                                      encoding: URLEncoding.default)
            
        case .uploadPhotoImage(dict: let parameters, difficult: let data):
            var formData: [Moya.MultipartFormData] = []
            let imageFormData = Moya.MultipartFormData(provider: .data(data),
                                                       name: "difficult",
                                                       fileName: "difficult.jpg",
                                                       mimeType: "image/jpeg")
            formData.append(imageFormData)
            for (key, value) in parameters {
                if let valueData = "\(value)".data(using: .utf8) {
                    let paramFormData = Moya.MultipartFormData(provider: .data(valueData), name: key)
                    formData.append(paramFormData)
                }
            }
            return .uploadMultipart(formData)
            
        case .saveNameInfo(old: let old, name: let name, num: let num, date: let date, defeated: let defeated):
            return .requestParameters(parameters: ["old": old,
                                                   "bed": name,
                                                   "willpower": num,
                                                   "strong": date,
                                                   "defeated": defeated,
                                                   "large": "11",
                                                   "stabilize": "idcard"],
                                      encoding: URLEncoding.default)
            
        case .getTwoInfo(old: let old):
            return .requestParameters(parameters: ["old": old,
                                                   "bedfly": "name",
                                                   "weak": "onedate",
                                                   "define": "young",
                                                   "small": "11"],
                                      encoding: URLEncoding.default)
            
        case .saveTPinfo(emptyDict: let emptyDict):
            return .requestParameters(parameters: emptyDict,
                                      encoding: URLEncoding.default)
            
            
        case .getTttInfo(old: let old):
            return .requestParameters(parameters: ["old": old,
                                                   "bbq": "1",
                                                   "porcuse": "buy"],
                                      encoding: URLEncoding.default)
            
        case .saveTtPinfo(emptyDict: let emptyDict):
            return .requestParameters(parameters: emptyDict,
                                      encoding: URLEncoding.default)
            
        case .getlululemonInfo(old: let old):
            return .requestParameters(parameters: ["pp": "special",
                                                   "old": old,
                                                   "lulu": "more",
                                                   "lemon": "laji"],
                                      encoding: URLEncoding.default)
            
        case .savelululemoninfo(emptyDict: let emptyDict), .saveGoldenInfo(emptyDict: let emptyDict),
                .tonexturl(emptyDict: let emptyDict),
                .getOListInfo(emptyDict: let emptyDict):
            return .requestParameters(parameters: emptyDict,
                                      encoding: URLEncoding.default)
            
        case .uploadPhoneInfo(emptyDict: let emptyDict), .savePPoneInfo(emptyDict: let emptyDict):
            var formData: [Moya.MultipartFormData] = []
            for (key, value) in emptyDict {
                if let valueData = "\(value)".data(using: .utf8) {
                    let paramFormData = Moya.MultipartFormData(provider: .data(valueData), name: key)
                    formData.append(paramFormData)
                }
            }
            return .uploadMultipart(formData)
            
        case .hqGoldenInfo(sparring: let sparring, mistake: let mistake):
            return .requestParameters(parameters: ["sparring": sparring, "mistake": mistake, "ap": "one"], encoding: URLEncoding.default)
            
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
        case .tocode:
            return "/allow/embroiled"
        case .tologin:
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
        case .uploadPhotoImage:
            return "/allow/forward"
        case .saveNameInfo:
            return "/allow/stood"
        case .getTwoInfo:
            return "/allow/palace"
        case .getRegion:
            return "/allow/inchsu"
        case .saveTPinfo:
            return "/allow/guards"
        case .getTttInfo:
            return "/allow/leave"
        case .saveTtPinfo:
            return "/allow/suddenly"
        case .getlululemonInfo:
            return "/allow/country"
        case .savelululemoninfo:
            return "/allow/silently"
        case .uploadPhoneInfo:
            return "/allow/expressionless"
        case .savePPoneInfo:
            return "/allow/silently"
        case .hqGoldenInfo:
            return "/allow/knife"
        case .saveGoldenInfo:
            return "/allow/midway"
        case .tonexturl:
            return "/allow/would"
        case .getOListInfo:
            return "/allow/anymore"
        }
        
    }
    
    var sampleData: Data {
        return Data()
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
