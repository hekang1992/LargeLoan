//
//  KFCTableViewCell.swift
//  LargeLoan
//
//  Created by 何康 on 2024/12/19.
//

import UIKit

class KFCTableViewCell: BaseTableViewCell {
    
    lazy var bigManLabel: UILabel = {
        let bigManLabel = UILabel()
        bigManLabel.textColor = UIColor.init(cssStr: "#2B170A")
        bigManLabel.textAlignment = .left
        bigManLabel.font = .regularFontOfSize(size: 14)
        return bigManLabel
    }()
    
    lazy var pereImageView: UIImageView = {
        let pereImageView = UIImageView()
        pereImageView.image = UIImage(named: "backheis")
        return pereImageView
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .init(cssStr: "#EEEEEE")
        return lineView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bigManLabel)
        contentView.addSubview(pereImageView)
        
        bigManLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.equalToSuperview().offset(14)
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(17)
            make.bottom.equalToSuperview().offset(-14)
        }
        pereImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 12, height: 12))
            make.right.equalToSuperview().offset(-24)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
