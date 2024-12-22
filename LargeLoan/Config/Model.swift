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
    var raised: String?//facetoimge
    var blow: Int?
    var palms: palmsModel?
    var guess: guessModel?
    var her: herModel?
    var smiled: smiledModel?
    var big: [[String]]?
    var bed: String?
    var strong: String?
    var willpower: String?
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

struct herModel: Codable {
    var digging: String?
}

struct smiledModel: Codable {
    var ever: Int?
    var raised: String?//idtoimage
    var determination: determinationModel?
}

struct determinationModel: Codable {
    var oneName: String?
    var twoNumbe: String?
    var threeDate: String?
    enum CodingKeys: String, CodingKey {
        case oneName = "bed"
        case twoNumbe = "willpower"
        case threeDate = "strong"
    }
}
