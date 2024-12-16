//
//  Model.swift
//  LargeLoan
//
//  Created by 何康 on 2024/12/16.
//

import Foundation


struct BaseModel: Codable {
    let anyone: String
    let coldly: String
    let exuding: exudingModel
}

struct exudingModel: Codable {
    let nonstop: String?
    let surroundings: String?
    let ad: String?
}
