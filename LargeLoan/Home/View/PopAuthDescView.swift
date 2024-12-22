//
//  PopAuthDescView.swift
//  LargeLoan
//
//  Created by 何康 on 2024/12/22.
//

import UIKit

class PopAuthDescView: BaseView {

    lazy var ctImageView: UIImageView = {
        let ctImageView = UIImageView()
        ctImageView.image = UIImage(named: "alketimageii")
        ctImageView.isUserInteractionEnabled = true
        return ctImageView
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
        oneView.mlabel.text = "Full Name"
        return oneView
    }()
    
    lazy var twoView: EnterTextView = {
        let twoView = EnterTextView()
        twoView.mlabel.text = "ID No."
        return twoView
    }()
    
    lazy var threeView: EnterBtnView = {
        let threeView = EnterBtnView()
        threeView.mlabel.text = "Date of Birth"
        return threeView
    }()
    
    lazy var mlabel: UILabel = {
        let mlabel = UILabel()
        mlabel.text = "*Please confirm relevant information"
        mlabel.textColor = UIColor.init(cssStr: "#FF0000")
        mlabel.textAlignment = .center
        mlabel.font = .mediumFontOfSize(size: 14)
        return mlabel
    }()
    
    lazy var sageBtn: UIButton = {
        let sageBtn = UIButton(type: .custom)
        sageBtn.setImage(UIImage(named: "complesageimge"), for: .normal)
        return sageBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(ctImageView)
        ctImageView.addSubview(backBtn)
        ctImageView.addSubview(ttlabel)
        ctImageView.addSubview(oneView)
        ctImageView.addSubview(twoView)
        ctImageView.addSubview(threeView)
        ctImageView.addSubview(mlabel)
        ctImageView.addSubview(sageBtn)
        ctImageView.snp.makeConstraints { make in
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
        
        mlabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(threeView.snp.bottom).offset(15)
            make.height.equalTo(18)
        }
        sageBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mlabel.snp.bottom).offset(4)
            make.size.equalTo(CGSize(width: 271, height: 52))
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
