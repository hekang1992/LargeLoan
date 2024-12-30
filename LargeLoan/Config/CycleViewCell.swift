//
//  CycleViewCell.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/29.
//

import UIKit
import RxSwift

class MainCycleCell: UICollectionViewCell {
    
    let disposeBag = DisposeBag()
    
    lazy var ipoImgaView: UIImageView = {
        let ipoImgaView = UIImageView()
        return ipoImgaView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(ipoImgaView)
        ipoImgaView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class SunViewCell: UICollectionViewCell {
    
    let disposeBag = DisposeBag()
    
    lazy var mlabel: UILabel = {
        let mlabel = UILabel()
        mlabel.textColor = .black
        mlabel.textAlignment = .left
        mlabel.numberOfLines = 2
        mlabel.font = .mediumFontOfSize(size: 12)
        return mlabel
    }()
    
    lazy var delabel: UILabel = {
        let delabel = UILabel()
        delabel.textColor = .init(named: "#FF7F38")
        delabel.textAlignment = .right
        delabel.font = .mediumFontOfSize(size: 13)
        let angle: Float = -5 * .pi / 180
        delabel.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
        return delabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mlabel)
        addSubview(delabel)
        mlabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(56)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-104)
        }
        delabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(56)
            make.right.equalToSuperview().offset(-24)
            make.width.equalTo(84)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
