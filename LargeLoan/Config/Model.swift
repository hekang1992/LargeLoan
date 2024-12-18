//
//  Model.swift
//  LargeLoan
//
//  Created by 何康 on 2024/12/16.
//

import Foundation


struct BaseModel: Codable {
    var anyone: String
    var coldly: String
    var exuding: exudingModel
}

struct exudingModel: Codable {
    var nonstop: String?
    var surroundings: String?
    var ad: String?
    var raised: String?
    var palms: palmsModel?
    var guess: guessModel?
}

struct palmsModel: Codable {
    var large: String?
    var something: [somethingModel]?
}

struct somethingModel: Codable {
    var digging: Int?
}

struct guessModel: Codable {
    var pungent: String?
}
