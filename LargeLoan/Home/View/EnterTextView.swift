//
//  EnterTextView.swift
//  LargeLoan
//
//  Created by 何康 on 2024/12/22.
//

import UIKit

class EnterTextView: BaseView {
    
    lazy var mlabel: UILabel = {
        let mlabel = UILabel()
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mlabel)
        addSubview(bgView)
        bgView.addSubview(enterTx)
        
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
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
