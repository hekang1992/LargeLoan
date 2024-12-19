//
//  StepView.swift
//  LargeLoan
//
//  Created by 何康 on 2024/12/19.
//

import UIKit

class StepView: BaseView {

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .init(cssStr: "#FF7F38")
        bgView.layer.cornerRadius = 12
        return bgView
    }()
    
    lazy var licon: UIImageView = {
        let licon = UIImageView()
        return licon
    }()
    
    lazy var ricon: UIImageView = {
        let ricon = UIImageView()
        ricon.image = UIImage(named: "vnormal")
        return ricon
    }()
    
    lazy var r1icon: UIImageView = {
        let r1icon = UIImageView()
        r1icon.image = UIImage(named: "rightimcopy")
        return r1icon
    }()
    
    lazy var mlabel: UILabel = {
        let mlabel = UILabel()
        mlabel.textColor = UIColor.init(cssStr: "#101D37")
        mlabel.textAlignment = .left
        mlabel.font = .mediumFontOfSize(size: 16)
        return mlabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(licon)
        bgView.addSubview(ricon)
        bgView.addSubview(r1icon)
        bgView.addSubview(mlabel)
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview()
            make.height.equalTo(60)
        }
        r1icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
            make.size.equalTo(CGSize(width: 16, height: 16))
        }
        ricon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(r1icon.snp.left).offset(-3)
            make.size.equalTo(CGSizeMake(20, 20))
        }
        licon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.size.equalTo(CGSize(width: 32, height: 32))
        }
        mlabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(licon.snp.right).offset(20)
            make.height.equalTo(40)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
