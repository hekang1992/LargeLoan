//
//  ProductViewCell.swift
//  LargeLoan
//
//  Created by 何康 on 2024/12/29.
//

import UIKit
import RxRelay

class ProductViewCell: BaseTableViewCell {
    
    var model = BehaviorRelay<somethingModel?>(value: nil)

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .init(cssStr: "#FFF6EB")
        bgView.layer.cornerRadius = 20
        return bgView
    }()
    
    lazy var namelabel: UILabel = {
        let namelabel = UILabel()
        namelabel.textColor = UIColor.init(cssStr: "#2B170A")
        namelabel.textAlignment = .left
        namelabel.font = .boldFontOfSize(size: 16)
        return namelabel
    }()
    
    lazy var desclabel: UILabel = {
        let desclabel = UILabel()
        desclabel.textColor = UIColor.init(cssStr: "#FFC438")
        desclabel.textAlignment = .left
        desclabel.font = .boldFontOfSize(size: 14)
        return desclabel
    }()
    
    lazy var pricelabel: UILabel = {
        let pricelabel = UILabel()
        pricelabel.textColor = UIColor.init(cssStr: "#2B170A")
        pricelabel.textAlignment = .left
        pricelabel.font = .boldFontOfSize(size: 30)
        return pricelabel
    }()
    
    lazy var viewlabel: PaddedLabel = {
        let viewlabel = PaddedLabel()
        viewlabel.textColor = .white
        viewlabel.textAlignment = .center
        viewlabel.font = .mediumFontOfSize(size: 14)
        viewlabel.backgroundColor = .init(cssStr: "#FF7F38")
        viewlabel.layer.cornerRadius = 8
        viewlabel.layer.masksToBounds = true
        return viewlabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        contentView.addSubview(namelabel)
        contentView.addSubview(desclabel)
        contentView.addSubview(pricelabel)
        contentView.addSubview(viewlabel)
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(120)
        }
        namelabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(36)
            make.top.equalToSuperview().offset(16)
            make.height.equalTo(19)
        }
        desclabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(36)
            make.top.equalTo(namelabel.snp.bottom).offset(10)
            make.height.equalTo(16)
        }
        pricelabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(36)
            make.top.equalTo(desclabel.snp.bottom).offset(8)
            make.height.equalTo(53)
            make.bottom.equalToSuperview().offset(-5)
        }
        viewlabel.snp.makeConstraints { make in
            make.centerY.equalTo(pricelabel.snp.centerY)
            make.right.equalToSuperview().offset(-36)
            make.height.equalTo(32)
        }
        model.asObservable().subscribe(onNext: { [weak self] model in
            guard let self = self, let model = model else { return }
            namelabel.text = model.nails ?? ""
            desclabel.text = model.nodding ?? ""
            pricelabel.text = model.wetting ?? ""
            let fra = model.far ?? ""
            if fra.isEmpty {
                viewlabel.isHidden = true
                viewlabel.text = ""
            }else {
                viewlabel.isHidden = false
                viewlabel.text = model.far ?? ""
            }
        }).disposed(by: disposeBag)
     
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

