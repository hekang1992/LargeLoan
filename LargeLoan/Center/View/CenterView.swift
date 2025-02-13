//
//  CenterView.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/15.
//

import UIKit

class CenterView: BaseView {

    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "centerbg")
        return bgImageView
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "icontou")
        return iconImageView
    }()

    lazy var minSoulLabel: UILabel = {
        let minSoulLabel = UILabel()
        minSoulLabel.text = "Greetings!"
        minSoulLabel.textColor = .white
        minSoulLabel.textAlignment = .left
        minSoulLabel.font = .mediumFontOfSize(size: 24)
        return minSoulLabel
    }()
    
    lazy var phonelabel: UILabel = {
        let phonelabel = UILabel()
        let phone = UserDefaults.standard.object(forKey: LOGIN_ONE) as? String ?? ""
        phonelabel.text = PhoneNumberFormatter.formatPhoneNumber(phoneNumber: phone)
        phonelabel.textColor = .white
        phonelabel.textAlignment = .left
        phonelabel.font = .regularFontOfSize(size: 24)
        return phonelabel
    }()
    
    lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        return whiteView
    }()
    
    lazy var lemonView: UIView = {
        let lemonView = UIView()
        lemonView.layer.cornerRadius = 16
        lemonView.backgroundColor = UIColor.init(colorHexStr: "#FF7F38")
        return lemonView
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        oneBtn.titleLabel?.font = .mediumFontOfSize(size: 12)
        oneBtn.setTitle("Apply", for: .normal)
        oneBtn.setImage(UIImage(named: "applyiocn"), for: .normal)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        twoBtn.titleLabel?.font = .mediumFontOfSize(size: 12)
        twoBtn.setTitle("Repayment", for: .normal)
        twoBtn.setImage(UIImage(named: "Repaymentimge"), for: .normal)
        return twoBtn
    }()
    
    lazy var threeBtn: UIButton = {
        let threeBtn = UIButton(type: .custom)
        threeBtn.titleLabel?.font = .mediumFontOfSize(size: 12)
        threeBtn.setTitle("Finished", for: .normal)
        threeBtn.setImage(UIImage(named: "Finishedimge"), for: .normal)
        return threeBtn
    }()
    
    lazy var serviceBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "kefuiamge"), for: .normal)
        return backBtn
    }()
    
    lazy var agreeBtn: UIButton = {
        let agreeBtn = UIButton(type: .custom)
        agreeBtn.setImage(UIImage(named: "agereiamge"), for: .normal)
        return agreeBtn
    }()
    
    lazy var setBtn: UIButton = {
        let setBtn = UIButton(type: .custom)
        setBtn.setImage(UIImage(named: "setupiamge"), for: .normal)
        return setBtn
    }()
    
    lazy var aboBtn: UIButton = {
        let aboBtn = UIButton(type: .custom)
        aboBtn.setImage(UIImage(named: "abouafd"), for: .normal)
        return aboBtn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        self.headView.backBtn.isHidden = true
        self.headView.lemonView.backgroundColor = .clear
        self.headView.namelabel.text = "Private Center"
        bgImageView.addSubview(self.headView)
        bgImageView.addSubview(iconImageView)
        bgImageView.addSubview(minSoulLabel)
        bgImageView.addSubview(phonelabel)
        
        addSubview(whiteView)
        addSubview(lemonView)
        lemonView.addSubview(oneBtn)
        lemonView.addSubview(threeBtn)
        lemonView.addSubview(twoBtn)
        
        whiteView.addSubview(serviceBtn)
        whiteView.addSubview(agreeBtn)
        whiteView.addSubview(setBtn)
        whiteView.addSubview(aboBtn)
        
        bgImageView.snp.makeConstraints { make in
            make.top.leading.right.equalToSuperview()
            make.height.equalTo(279)
        }
        headView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(StatusBarHeight + 50)
        }
        iconImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(26)
            make.size.equalTo(CGSize(width: 80, height: 80))
            make.top.equalTo(headView.snp.bottom)
        }
        minSoulLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.top).offset(7)
            make.left.equalTo(iconImageView.snp.right).offset(12)
            make.height.equalTo(33)
        }
        phonelabel.snp.makeConstraints { make in
            make.top.equalTo(minSoulLabel.snp.bottom).offset(4)
            make.left.equalTo(iconImageView.snp.right).offset(12)
            make.height.equalTo(29)
        }
        whiteView.snp.makeConstraints { make in
            make.top.equalTo(bgImageView.snp.bottom).offset(-44)
            make.left.right.bottom.equalToSuperview()
        }
        lemonView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(whiteView.snp.top).offset(-30)
            make.size.equalTo(CGSize(width: 343, height: 90))
        }
        oneBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(48)
            make.top.equalToSuperview().offset(21)
            make.size.equalTo(CGSize(width: 34, height: 50))
        }
        threeBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-47)
            make.top.equalToSuperview().offset(21)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        twoBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.left.equalTo(oneBtn.snp.right)
            make.right.equalTo(threeBtn.snp.left)
            make.height.equalTo(50)
        }
        serviceBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(85)
            make.left.equalToSuperview().offset(18)
            make.size.equalTo(CGSize(width: 104, height: 82))
        }
        agreeBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(85)
            make.right.equalToSuperview().offset(-14)
            make.size.equalTo(CGSize(width: 110, height: 82))
        }
        setBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(85)
            make.left.equalTo(serviceBtn.snp.right).offset(38)
            make.right.equalTo(agreeBtn.snp.left).offset(-35)
            make.height.equalTo(82)
        }
        aboBtn.snp.makeConstraints { make in
            make.top.equalTo(setBtn.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(42)
            make.size.equalTo(CGSize(width: 56, height: 82))
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CenterView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        whiteView.setTopCorners(radius: 20)
        oneBtn.layoutButtonEdgeInsets(style: .top, space: 11)
        twoBtn.layoutButtonEdgeInsets(style: .top, space: 14)
        threeBtn.layoutButtonEdgeInsets(style: .top, space: 11)
    }
    
}


class PhoneNumberFormatter {
    static func formatPhoneNumber(phoneNumber: String) -> String {
        if phoneNumber.count == 10 {
            let start = phoneNumber.prefix(3)
            let end = phoneNumber.suffix(4)
            let masked = String(repeating: "*", count: phoneNumber.count - 7)
            return start + masked + end
        }
        return phoneNumber
    }
}
