//
//  EnterTextView.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/22.
//

import UIKit

class EnterTextView: BaseView {
    
    lazy var bigManLabel: UILabel = {
        let bigManLabel = UILabel()
        bigManLabel.textColor = UIColor.init(cssStr: "#2B170A")
        bigManLabel.textAlignment = .left
        bigManLabel.font = .regularFontOfSize(size: 14)
        return bigManLabel
    }()
    
    lazy var lemonView: UIView = {
        let lemonView = UIView()
        lemonView.layer.cornerRadius = 12
        lemonView.backgroundColor = .init(cssStr: "#FFFFFF")
        return lemonView
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
        addSubview(bigManLabel)
        addSubview(lemonView)
        addSubview(enterTx)
        
        bigManLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.height.equalTo(17)
            make.left.equalToSuperview().offset(14)
            make.bottom.equalToSuperview().offset(-76)
        }
        lemonView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(14)
            make.top.equalTo(bigManLabel.snp.bottom).offset(10)
            make.height.equalTo(46)
        }
        enterTx.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(28)
            make.top.equalTo(bigManLabel.snp.bottom).offset(10)
            make.height.equalTo(46)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
