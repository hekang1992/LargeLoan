//
//  PopAuthDescView.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/22.
//

import UIKit

class PopAuthDescView: BaseView {

    lazy var pereImageView: UIImageView = {
        let pereImageView = UIImageView()
        pereImageView.image = UIImage(named: "alketimageii")
        pereImageView.isUserInteractionEnabled = true
        return pereImageView
    }()
    
    lazy var ttlabel: UILabel = {
        let ttlabel = UILabel()
        ttlabel.text = "Identity Information"
        ttlabel.textColor = UIColor.init(cssStr: "#2B170A")
        ttlabel.textAlignment = .center
        ttlabel.font = .boldFontOfSize(size: 18)
        return ttlabel
    }()
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "cancelimage"), for: .normal)
        return backBtn
    }()
    
    lazy var oneView: EnterTextView = {
        let oneView = EnterTextView()
        oneView.bigManLabel.text = "Full Name"
        return oneView
    }()
    
    lazy var twoView: EnterTextView = {
        let twoView = EnterTextView()
        twoView.bigManLabel.text = "ID No."
        return twoView
    }()
    
    lazy var threeView: EnterBtnView = {
        let threeView = EnterBtnView()
        threeView.bigManLabel.text = "Date of Birth"
        return threeView
    }()
    
    lazy var bigManLabel: UILabel = {
        let bigManLabel = UILabel()
        bigManLabel.text = "*Please confirm relevant information"
        bigManLabel.textColor = UIColor.init(cssStr: "#FF0000")
        bigManLabel.textAlignment = .center
        bigManLabel.font = .mediumFontOfSize(size: 14)
        return bigManLabel
    }()
    
    lazy var sageBtn: UIButton = {
        let sageBtn = UIButton(type: .custom)
        sageBtn.setImage(UIImage(named: "complesageimge"), for: .normal)
        return sageBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(pereImageView)
        pereImageView.addSubview(backBtn)
        pereImageView.addSubview(ttlabel)
        pereImageView.addSubview(oneView)
        pereImageView.addSubview(twoView)
        pereImageView.addSubview(threeView)
        pereImageView.addSubview(bigManLabel)
        pereImageView.addSubview(sageBtn)
        pereImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 315, height: 456))
        }
        backBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 26, height: 26))
        }
        ttlabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(40)
            make.height.equalTo(22)
        }
        oneView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(82)
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(73)
        }
        
        twoView.snp.makeConstraints { make in
            make.top.equalTo(oneView.snp.bottom).offset(20)
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(73)
        }
        
        threeView.snp.makeConstraints { make in
            make.top.equalTo(twoView.snp.bottom).offset(20)
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(73)
        }
        
        bigManLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(threeView.snp.bottom).offset(15)
            make.height.equalTo(18)
        }
        sageBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bigManLabel.snp.bottom).offset(4)
            make.size.equalTo(CGSize(width: 271, height: 52))
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
