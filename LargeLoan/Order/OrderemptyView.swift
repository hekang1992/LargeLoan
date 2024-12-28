//
//  OrderemptyView.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/28.
//

import UIKit

class OrderemptyView: BaseView {
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        return bgView
    }()
    
    lazy var iconBg: UIImageView = {
        let iconBg = UIImageView()
        iconBg.image = UIImage(named: "iamgeenpmn")
        return iconBg
    }()
    
    lazy var appBtn: UIButton = {
        let appBtn = UIButton(type: .custom)
        appBtn.setImage(UIImage(named: "goappenze"), for: .normal)
        return appBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(iconBg)
        bgView.addSubview(appBtn)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        iconBg.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.left.equalTo((SCREEN_WIDTH - 200) * 0.5)
            make.size.equalTo(CGSize(width: 200, height: 216))
        }
        appBtn.snp.makeConstraints { make in
            make.centerX.equalTo(iconBg.snp.centerX)
            make.top.equalTo(iconBg.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 271, height: 48))
        }
        
        appBtn.rx.tap.subscribe(onNext: {
            PushRootVcConfig.goRootVc()
        }).disposed(by: disposeBag)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class AddEmptyManager {
    
    private lazy var emptyView = OrderemptyView()
    
    func showEmptyView(on targetView: UIView) {
        guard emptyView.superview == nil else { return }
        targetView.addSubview(emptyView)
        
        emptyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    func hideEmptyView() {
        emptyView.removeFromSuperview()
    }
    
}
