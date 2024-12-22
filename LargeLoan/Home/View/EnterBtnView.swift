//
//  EnterBtnView.swift
//  LargeLoan
//
//  Created by 何康 on 2024/12/22.
//

import UIKit

class EnterBtnView: BaseView {

    lazy var mlabel: UILabel = {
        let mlabel = UILabel()
        mlabel.text = "fads"
        mlabel.textColor = UIColor.init(cssStr: "#2B170A")
        mlabel.textAlignment = .left
        mlabel.font = .regularFontOfSize(size: 14)
        return mlabel
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 12
        bgView.backgroundColor = .init(cssStr: "#FFFFFF")
        return bgView
    }()
    
    lazy var enterTx: UITextField = {
        let enterTx = UITextField()
        let attrString = NSMutableAttributedString(string: "Please Enter", attributes: [
            .foregroundColor: UIColor.init(cssStr: "#2B170A")?.withAlphaComponent(0.6) as Any,
            .font: UIFont.mediumFontOfSize(size: 14)
        ])
        enterTx.attributedPlaceholder = attrString
        enterTx.font = .mediumFontOfSize(size: 14)
        enterTx.textColor = UIColor.init(cssStr: "#2B170A")
        return enterTx
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        return clickBtn
    }()
    
    lazy var ctImageView: UIImageView = {
        let ctImageView = UIImageView()
        ctImageView.image = UIImage(named: "blackiamgejiant")
        return ctImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mlabel)
        addSubview(bgView)
        bgView.addSubview(enterTx)
        bgView.addSubview(clickBtn)
        bgView.addSubview(ctImageView)
        mlabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(17)
            make.left.equalToSuperview().offset(14)
        }
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(14)
            make.top.equalTo(mlabel.snp.bottom).offset(10)
            make.height.equalTo(46)
        }
        enterTx.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(14)
            make.top.bottom.right.equalToSuperview()
        }
        clickBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        ctImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-14)
            make.size.equalTo(CGSize(width: 12, height: 12))
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
