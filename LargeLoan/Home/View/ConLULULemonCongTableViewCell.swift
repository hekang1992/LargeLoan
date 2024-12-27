//
//  ConLULULemonCongTableViewCell.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/25.
//

import UIKit
import RxRelay

class ConLULULemonCongTableViewCell: BaseTableViewCell {
    
    var oneblock: ((UITextField) -> Void)?
    var twoblock: ((UITextField) -> Void)?
    
    var model = BehaviorRelay<letModel?>(value: nil)

    lazy var lemonView: UIView = {
        let lemonView = UIView()
        lemonView.layer.cornerRadius = 12
        lemonView.backgroundColor = .init(cssStr: "#FFFAF1")
        return lemonView
    }()
    
    lazy var littleLineView: UIView = {
        let littleLineView = UIView()
        littleLineView.backgroundColor = .init(cssStr: "#FF7F38")
        return littleLineView
    }()

    lazy var mlabel: UILabel = {
        let mlabel = UILabel()
        mlabel.textColor = .white
        mlabel.textAlignment = .left
        mlabel.font = .mediumFontOfSize(size: 16)
        return mlabel
    }()
    
    lazy var gxView: EnterBtnView = {
        let gxView = EnterBtnView()
        return gxView
    }()
    
    lazy var phoneView: EnterBtnView = {
        let phoneView = EnterBtnView()
        phoneView.pereImageView.isHidden = true
        return phoneView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(lemonView)
        lemonView.addSubview(littleLineView)
        
        lemonView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(244)
        }
        littleLineView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalTo(SCREEN_WIDTH - 32)
            make.left.equalToSuperview()
            make.height.equalTo(44)
        }
        
        littleLineView.addSubview(mlabel)
        mlabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(14)
            make.height.equalTo(19)
        }
        
        
        lemonView.addSubview(gxView)
        lemonView.addSubview(phoneView)
        
        gxView.snp.makeConstraints { make in
            make.top.equalTo(littleLineView.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(93)
        }
        
        phoneView.snp.makeConstraints { make in
            make.top.equalTo(gxView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(93)
        }
        
        layoutIfNeeded()
        littleLineView.setTopCorners(radius: 12)
        
        
        model.asObservable().subscribe(onNext: { [weak self] model in
            guard let self = self, let model = model else { return }
            mlabel.text = model.cried
            gxView.bigManLabel.text = model.storm
            gxView.enterTx.placeholder = model.went
            phoneView.bigManLabel.text = model.armies
            phoneView.enterTx.placeholder = model.mortals
            
            if let relationText = model.relationText, !relationText.isEmpty {
                gxView.enterTx.text = relationText
            }
            if let bed = model.bed, !bed.isEmpty, let outcome = model.outcome, !outcome.isEmpty  {
                phoneView.enterTx.text = "name:(\(bed)) phone:(\(outcome))"
            }
            
        }).disposed(by: disposeBag)
        
        
        gxView.clickBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.oneblock?(self.gxView.enterTx)
        }).disposed(by: disposeBag)
        
        phoneView.clickBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.twoblock?(self.phoneView.enterTx)
        }).disposed(by: disposeBag)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


