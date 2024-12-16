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

enum LargeLoanAPI {
    case tocode(phone: String)
    case tologin(phone: String, code: String)
}

extension LargeLoanAPI: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: apiHost) else { fatalError("InvalidURL")
        }
        let apiUrl = DictToString.appendters(url: url.absoluteString, parameters: loginConfig) ?? ""
        return URL(string: apiUrl)!
    }
    
    var method: Moya.Method {
        switch self {
        case .tocode, .tologin:
            return .post
            
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .tocode(phone: let shall):
            return .requestParameters(parameters: ["shall": shall, "type": "code"], encoding: URLEncoding.default)
        case .tologin(phone: let surroundings, code: let surveyed):
            return .requestParameters(parameters: ["surroundings": surroundings, "surveyed": surveyed, "type": "login"], encoding: URLEncoding.default)
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
        case .tocode(let phone):
            return "/allow/embroiled"
        case .tologin(let phone, let code):
            return "/allow/hunting"
            
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
