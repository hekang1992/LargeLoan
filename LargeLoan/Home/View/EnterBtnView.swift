//
//  EnterBtnView.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/22.
//

import UIKit

class EnterBtnView: BaseView {
    
    var block: ((UIButton, UITextField) -> Void)?

    lazy var bigManLabel: UILabel = {
        let bigManLabel = UILabel()
        bigManLabel.textColor = UIColor.init(colorHexStr: "#2B170A")
        bigManLabel.textAlignment = .left
        bigManLabel.font = .regularFontOfSize(size: 14)
        return bigManLabel
    }()
    
    lazy var lemonView: UIView = {
        let lemonView = UIView()
        lemonView.layer.cornerRadius = 12
        lemonView.backgroundColor = .init(colorHexStr: "#FFFFFF")
        return lemonView
    }()
    
    lazy var enterTx: UITextField = {
        let enterTx = UITextField()
        let attrString = NSMutableAttributedString(string: "Please Enter", attributes: [
            .foregroundColor: UIColor.init(colorHexStr: "#2B170A")?.withAlphaComponent(0.6) as Any,
            .font: UIFont.mediumFontOfSize(size: 14)
        ])
        enterTx.attributedPlaceholder = attrString
        enterTx.font = .mediumFontOfSize(size: 14)
        enterTx.textColor = UIColor.init(colorHexStr: "#2B170A")
        enterTx.isEnabled = false
        return enterTx
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        return clickBtn
    }()
    
    lazy var pereImageView: UIImageView = {
        let pereImageView = UIImageView()
        pereImageView.image = UIImage(named: "blackiamgejiant")
        return pereImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bigManLabel)
        addSubview(lemonView)
        addSubview(enterTx)
        lemonView.addSubview(clickBtn)
        lemonView.addSubview(pereImageView)
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
        clickBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        pereImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-14)
            make.size.equalTo(CGSize(width: 12, height: 12))
        }
        
        clickBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.block?(clickBtn, enterTx)
        }).disposed(by: disposeBag)
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
