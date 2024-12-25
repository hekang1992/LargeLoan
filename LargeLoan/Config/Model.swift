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
    var common: [commonModel]?
    var region: [letModel]?
    enum CodingKeys: String, CodingKey {
        case nonstop
        case surroundings
        case ad
        case raised
        case blow
        case palms
        case guess
        case her
        case smiled
        case big
        case bed
        case strong
        case willpower
        case common
        case region = "let" // 需要自定义映射
    }
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

class commonModel: Codable {
    var anyone: String?//key
    var nourishing: Int?//jianpan
    var smile: String?//name
    var medicine: String?//place
    var pill: String?//celltype
    var breathing: String?//huixie
    var large: String?//huixiekey
    var essence: [essenceModel]?
    init(anyone: String? = nil, nourishing: Int? = nil, smile: String? = nil, medicine: String? = nil, pill: String? = nil, breathing: String? = nil, large: String? = nil, essence: [essenceModel]? = nil) {
        self.anyone = anyone
        self.nourishing = nourishing
        self.smile = smile
        self.medicine = medicine
        self.pill = pill
        self.breathing = breathing
        self.large = large
        self.essence = essence
    }
}

class essenceModel: Codable {
    var bed: String?
    var large: Int?
    init(bed: String? = nil, large: Int? = nil) {
        self.bed = bed
        self.large = large
    }
}

struct letModel: Codable {
    var bed: String?
    var digging: Int?
    var region: [letModel]?
    enum CodingKeys: String, CodingKey {
        case bed = "bed"
        case digging = "digging"
        case region = "let"
    }
}
