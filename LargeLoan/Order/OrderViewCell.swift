//
//  OrderViewCell.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/28.
//

import UIKit
import RxRelay

class OrderViewCell: BaseTableViewCell {
    
    var model = BehaviorRelay<letModel?>(value: nil)

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 16
        bgView.backgroundColor = .init(cssStr: "#FFF5E9")
        return bgView
    }()
    
    lazy var namelabel: UILabel = {
        let namelabel = UILabel()
        namelabel.textColor = UIColor.init(cssStr: "#2B170A")
        namelabel.textAlignment = .left
        namelabel.font = .boldFontOfSize(size: 19)
        return namelabel
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.backgroundColor = .random()
        iconImageView.layer.cornerRadius = 4
        return iconImageView
    }()
    
    lazy var timelabel: UILabel = {
        let timelabel = UILabel()
        timelabel.textColor = UIColor.init(cssStr: "#2B170A")?.withAlphaComponent(0.6)
        timelabel.textAlignment = .right
        timelabel.font = .regularFontOfSize(size: 16)
        return timelabel
    }()
    
    lazy var mlabel: UILabel = {
        let mlabel = UILabel()
        mlabel.textColor = UIColor.init(cssStr: "#2B170A")
        mlabel.textAlignment = .left
        mlabel.font = .boldFontOfSize(size: 35)
        return mlabel
    }()
    
    lazy var tImageView: UIImageView = {
        let tImageView = UIImageView()
        tImageView.image = UIImage(named: "errorimage")
        return tImageView
    }()
    
    lazy var deslabel: UILabel = {
        let deslabel = UILabel()
        deslabel.textColor = UIColor.init(cssStr: "#2B170A")?.withAlphaComponent(0.4)
        deslabel.textAlignment = .left
        deslabel.font = .regularFontOfSize(size: 12)
        return deslabel
    }()
    
    lazy var vw: UIView = {
        let vw = UIView()
        vw.backgroundColor = .random()
        return vw
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.setTitleColor(.white, for: .normal)
        nextBtn.titleLabel?.font = .regularFontOfSize(size: 12)
        nextBtn.setImage(UIImage(named: "eigthiapprl"), for: .normal)
        return nextBtn
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        contentView.addSubview(iconImageView)
        contentView.addSubview(namelabel)
        contentView.addSubview(timelabel)
        contentView.addSubview(mlabel)
        contentView.addSubview(tImageView)
        contentView.addSubview(deslabel)
        bgView.addSubview(vw)
        vw.addSubview(nextBtn)
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(161)
        }
        vw.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 120, height: 38))
        }
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(32)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        namelabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView.snp.centerY)
            make.left.equalTo(iconImageView.snp.right).offset(5)
            make.height.equalTo(19)
        }
        timelabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView.snp.centerY)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(16)
        }
        mlabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(32)
            make.top.equalTo(timelabel.snp.bottom).offset(26)
            make.height.equalTo(53)
        }
        tImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 14, height: 14))
            make.left.equalToSuperview().offset(32)
            make.top.equalTo(mlabel.snp.bottom).offset(22)
            make.bottom.equalToSuperview().offset(-36)
        }
        deslabel.snp.makeConstraints { make in
            make.centerY.equalTo(tImageView.snp.centerY)
            make.left.equalTo(tImageView.snp.right).offset(2)
            make.height.equalTo(14)
        }
        nextBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        model.asObservable().subscribe(onNext: { [weak self] model in
            guard let self = self, let model = model else { return }
            iconImageView.kf.setImage(with: URL(string: model.keeping ?? ""))
            namelabel.text = model.nails ?? ""
            timelabel.text = model.dateValue ?? ""
            mlabel.text = model.orderAmount ?? ""
            deslabel.text = model.orderStatusDesc ?? ""
            nextBtn.setTitle(model.statusTextDescButton ?? "", for: .normal)
            let replied = model.replied ?? 0
            var colstr: String = ""
            if replied == 1 {
                colstr = "#FF5F5E"
            }else if replied == 2 {
                colstr = "#FFB95E"
            }else if replied == 3 {
                colstr = "#FF7F38"
            }else if replied == 4 {
                colstr = "#47E0E3"
            }else if replied == 5 {
                colstr = "#D9C5B9"
            }else {
                colstr = "#FF7F38"
            }
            vw.backgroundColor = UIColor.init(cssStr: colstr)
        }).disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OrderViewCell {
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.layoutIfNeeded()
        vw.setLeftCorners(radius: 20)
        nextBtn.layoutButtonEdgeInsets(style: .right, space: 2)
    }
    
}
