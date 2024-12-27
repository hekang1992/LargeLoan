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
    var her: herModel?
    var smiled: smiledModel?
    var big: [[String]]?
    var bed: String?
    var strong: String?
    var willpower: String?
    var common: [commonModel]?
    var region: [letModel]?
    var unfortunately: unfortunatelyModel?
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
        case region = "let"
        case unfortunately
    }
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
    var essence: [essenceModel]?
    enum CodingKeys: String, CodingKey {
        case bed = "bed"
        case large = "large"
        case essence = "essence"
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
            self.large = intValue
        } else if let stringValue = try? container.decodeIfPresent(String.self, forKey: .large) {
            self.large = Int(stringValue)
        } else {
            self.large = nil
        }
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
    enum CodingKeys: String, CodingKey {
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
    }
}
