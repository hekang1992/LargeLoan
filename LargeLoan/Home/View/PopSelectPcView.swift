//
//  PopSelectPcView.swift
//  LargeLoan
//
//  Created by 何康 on 2024/12/22.
//

import UIKit

class PopSelectPcView: BaseView {

    lazy var pereImageView: UIImageView = {
        let pereImageView = UIImageView()
        pereImageView.image = UIImage(named: "opimgert")
        return pereImageView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 4
        return bgView
    }()
    
    lazy var bgView1: UIView = {
        let bgView1 = UIView()
        bgView1.layer.cornerRadius = 4
        return bgView1
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(pereImageView)
        pereImageView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(280)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
