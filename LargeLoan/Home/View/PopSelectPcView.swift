//
//  PopSelectPcView.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/22.
//

import UIKit

class PopSelectPcView: BaseView {

    lazy var pereImageView: UIImageView = {
        let pereImageView = UIImageView()
        pereImageView.image = UIImage(named: "opimgert")
        return pereImageView
    }()
    
    lazy var lemonView: UIView = {
        let lemonView = UIView()
        lemonView.layer.cornerRadius = 4
        return lemonView
    }()
    
    lazy var lemonView1: UIView = {
        let lemonView1 = UIView()
        lemonView1.layer.cornerRadius = 4
        return lemonView1
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
