//
//  PillConfig.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/24.
//

import UIKit
import BRPickerView


class ShowEnumConfig {
    
    static func popPhoneConfig(from letmodel: letModel,
                          tx: UITextField,
                          dataSource: [BRProvinceModel],
                          model: BRAddressPickerMode) {
        let pickerView = BRAddressPickerView()
        pickerView.pickerMode = model
        pickerView.title = letmodel.went ?? ""
        pickerView.selectIndexs = [0, 0, 0]
        pickerView.dataSourceArr = dataSource
        pickerView.resultBlock = { province, city, area in
            let (addressString, code) = generateAddressAndCode(province: province, city: city, area: area)
            letmodel.relationText = addressString
            letmodel.might = code
            tx.text = addressString
        }
        pickerView.pickerStyle = ColorEnemConfig.configureStyle()
        pickerView.show()
    }
    
    
    static func popConfig(from commonModel: commonModel,
                          tx: UITextField,
                          dataSource: [BRProvinceModel],
                          model: BRAddressPickerMode) {
        let pickerView = BRAddressPickerView()
        pickerView.pickerMode = model
        pickerView.title = commonModel.medicine ?? ""
        pickerView.selectIndexs = [0, 0, 0]
        pickerView.dataSourceArr = dataSource
        pickerView.resultBlock = { province, city, area in
            let (addressString, code) = generateAddressAndCode(province: province, city: city, area: area)
            commonModel.breathing = addressString
            commonModel.large = code
            tx.text = addressString
        }
        pickerView.pickerStyle = ColorEnemConfig.configureStyle()
        pickerView.show()
    }

    private static func generateAddressAndCode(province: BRProvinceModel?,
                                               city: BRCityModel?,
                                               area: BRAreaModel?) -> (String, String) {
        let oneName = province?.name ?? ""
        let twoName = city?.name ?? ""
        let threeName = area?.name ?? ""
        let name: String
        let code: String
        switch (oneName.isEmpty, twoName.isEmpty, threeName.isEmpty) {
        case (false, true, _):
            name = oneName
            code = province?.code ?? ""
        case (false, false, true):
            let nameStr = "\(oneName)" + "|" + "\(twoName)"
            name = nameStr
            let codeStr = "\(province?.code ?? "")" + "|" + "\(city?.code ?? "")"
            code = codeStr
        case (false, false, false):
            name = "\(oneName)|\(twoName)|\(threeName)"
            code = "\(province?.code ?? "")|\(city?.code ?? "")|\(area?.code ?? "")"
        default:
            name = ""
            code = ""
        }
        return (name, code)
    }
}

class ColorEnemConfig {
    static  func configureStyle() -> BRPickerStyle {
        let customStyle = BRPickerStyle()
        customStyle.pickerColor = .white
        customStyle.pickerTextFont = .mediumFontOfSize(size: 16)
        customStyle.selectRowTextColor = .black
        return customStyle
    }
    
}
