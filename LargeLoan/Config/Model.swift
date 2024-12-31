//
//  Model.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/16.
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
    var smiled: smiledModel?
    var big: [[String]]?
    var bed: String?
    var strong: String?
    var willpower: String?
    var common: [commonModel]?
    var region: [letModel]?
    var unfortunately: unfortunatelyModel?
    var her: herModel?
    var sparkle: Int?
    var skin: skinModel?
    var cut: kneltModel?
    var knelt: kneltModel?
    var fact: String?
    enum CodingKeys: String, CodingKey {
        case knelt
        case cut
        case skin
        case sparkle
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
        case region = "let"
        case unfortunately
    }
}

struct skinModel: Codable {
    var something: [somethingModel]?
}

struct unfortunatelyModel: Codable {
    var region: [letModel]?
    enum CodingKeys: String, CodingKey {
        case region = "let"
    }
}

struct palmsModel: Codable {
    var large: String?
    var something: [somethingModel]?
}

struct somethingModel: Codable {
    var digging: Int?
    var nodding: String?
    var wetting: String?
    var far: String?
    var onto: String?
    var mid: String?
    var oozing: String?
    var raised: String?
    var coldly: String?
    var failed: String?
    var nails: String?
    var repay_btn_text: String?
    var keeping: String?
}

struct guessModel: Codable {
    var pungent: String?
}

struct herModel: Codable {
    var digging: String?
    var older: String?
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
    var common: [commonModel]?
    
    enum CodingKeys: String, CodingKey {
        case anyone = "anyone"
        case nourishing = "nourishing"
        case smile = "smile"
        case medicine = "medicine"
        case pill = "pill"
        case breathing = "breathing"
        case large = "large"
        case essence = "essence"
        case common = "common"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.anyone = try container.decodeIfPresent(String.self, forKey: .anyone)
        self.nourishing = try container.decodeIfPresent(Int.self, forKey: .nourishing)
        self.smile = try container.decodeIfPresent(String.self, forKey: .smile)
        self.medicine = try container.decodeIfPresent(String.self, forKey: .medicine)
        self.pill = try container.decodeIfPresent(String.self, forKey: .pill)
        self.breathing = try container.decodeIfPresent(String.self, forKey: .breathing)
        if let largeNumber = try? container.decode(Int.self, forKey: .large) {
            large = String(largeNumber)
        } else if let largeString = try? container.decode(String.self, forKey: .large) {
            large = largeString
        } else {
            throw DecodingError.typeMismatch(String.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Expected a String or Int for 'large'."))
        }
        self.essence = try container.decodeIfPresent([essenceModel].self, forKey: .essence)
        self.common = try container.decodeIfPresent([commonModel].self, forKey: .common)
    }
}

class essenceModel: Codable {
    var bed: String?
    var large: String?
    var die: String?
    var essence: [essenceModel]?
    enum CodingKeys: String, CodingKey {
        case bed = "bed"
        case large = "large"
        case essence = "essence"
        case die = "die"
    }
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let intValue = try? container.decodeIfPresent(Int.self, forKey: .bed) {
            self.bed = String(intValue)
        } else if let stringValue = try? container.decodeIfPresent(String.self, forKey: .bed) {
            self.bed = stringValue
        } else {
            self.bed = nil
        }
        if let intValue = try? container.decodeIfPresent(Int.self, forKey: .large) {
            self.large = String(intValue)
        } else if let stringValue = try? container.decodeIfPresent(String.self, forKey: .large) {
            self.large = stringValue
        } else {
            self.large = nil
        }
        self.die = try container.decodeIfPresent(String.self, forKey: .die)
        self.essence = try container.decodeIfPresent([essenceModel].self, forKey: .essence)
    }
}

class letModel: Codable {
    var bed: String?
    var digging: Int?
    var region: [letModel]?
    var cried: String?
    var mortals: String?
    var storm: String?
    var went: String?
    var armies: String?
    var normal: [essenceModel]?
    var outcome: String?
    var might: String?
    var relationText: String?
    var arrows: String?
    var keeping: String?
    var nails: String?
    var dateValue: String?
    var orderAmount: String?
    var orderStatusDesc: String?
    var statusTextDescButton: String?
    var replied: Int?
    var countries: String?
    enum CodingKeys: String, CodingKey {
        case countries = "countries"
        case replied = "replied"
        case keeping = "keeping"
        case might = "might"
        case relationText = "relationText"
        case outcome = "outcome"
        case bed = "bed"
        case digging = "digging"
        case region = "let"
        case cried = "cried"
        case mortals = "mortals"
        case storm = "storm"
        case went = "went"
        case normal = "normal"
        case armies = "armies"
        case arrows = "arrows"
        case nails = "nails"
        case dateValue = "dateValue"
        case orderAmount = "orderAmount"
        case orderStatusDesc = "orderStatusDesc"
        case statusTextDescButton = "statusTextDescButton"
    }
}

struct kneltModel: Codable {
    var something: [somethingModel]?
    
    enum CodingKeys: String, CodingKey {
        
    case something = "something"
        
    }
}
