//
//  ClickBtnConfig.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/24.
//

import UIKit
import BRPickerView

class ClickTypeModel {
    static func oneArray(dataArray: [Any]) -> [BRProvinceModel] {
        dataArray.enumerated().compactMap { index, item in
            guard let provinceDic = item as? essenceModel else {
                return nil
            }
            let provinceModel = BRProvinceModel().apply {
                $0.name = provinceDic.bed
                $0.code = provinceDic.large ?? ""
                $0.index = index
            }
            return provinceModel
        }
    }
}

extension BRProvinceModel {
    func apply(_ closure: (BRProvinceModel) -> Void) -> BRProvinceModel {
        closure(self)
        return self
    }
}



extension ClickTypeModel {
    static func threeArray(dataArr: [Any]) -> [BRProvinceModel] {
        return dataArr.compactMap { proviceDic in
            guard let proviceDic = proviceDic as? letModel else { return nil }
            let oneModel = BRProvinceModel()
            oneModel.code = String(proviceDic.digging ?? 0)
            oneModel.name = proviceDic.bed ?? ""
            if let provinceIndex = dataArr.firstIndex(where: { $0 as AnyObject === proviceDic as AnyObject }) {
                oneModel.index = provinceIndex
            } else {
                oneModel.index = 0
            }
            
            let cityList = proviceDic.region ?? []
            oneModel.citylist = cityList.compactMap { cityDic in
                let twoModel = BRCityModel()
                twoModel.code = String(cityDic.digging ?? 0)
                twoModel.name = cityDic.bed ?? ""
                if let cityIndex = cityList.firstIndex(where: { $0 as AnyObject === cityDic as AnyObject }) {
                    twoModel.index = cityIndex
                } else {
                    twoModel.index = 0
                }

                let areaList = cityDic.region ?? []
                twoModel.arealist = areaList.compactMap { areaDic in
                    let threeModel = BRAreaModel()
                    threeModel.code = String(areaDic.digging ?? 0)
                    threeModel.name = areaDic.bed ?? ""
                    if let areaIndex = areaList.firstIndex(where: { $0 as AnyObject === areaDic as AnyObject }) {
                        threeModel.index = areaIndex
                    } else {
                        threeModel.index = 0
                    }
                    
                    return threeModel
                }
                
                return twoModel
            }
            
            return oneModel
        }
    }
}


extension ClickTypeModel {
    
    static func twoArray(dataArray: [Any]) -> [BRProvinceModel] {
        return dataArray.compactMap { data in
            guard let provinceData = data as? essenceModel else { return nil }

            let provinceModel = BRProvinceModel()
            provinceModel.code = provinceData.large ?? ""
            provinceModel.name = provinceData.bed ?? ""
            provinceModel.index = dataArray.firstIndex { $0 as AnyObject === provinceData as AnyObject } ?? 0

            provinceModel.citylist = provinceData.essence?.compactMap { cityData in
                let cityModel = BRCityModel()
                cityModel.code = cityData.large ?? ""
                cityModel.name = cityData.bed ?? ""
                cityModel.index = provinceData.essence?.firstIndex { $0 as AnyObject === cityData as AnyObject } ?? 0
                
                return cityModel
            } ?? []

            return provinceModel
        }
    }
}


