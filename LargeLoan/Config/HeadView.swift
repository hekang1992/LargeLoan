//
//  HeadView.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/15.
//

import UIKit

class StatusBarConfig {
    static func getStatusBarHeight() -> CGFloat {
        return (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.statusBarManager?.statusBarFrame.height ?? 0
    }
    
    static var safeAreaBottomHeight:CGFloat {
        var safeHeight: CGFloat = 0;
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.delegate!.window!!
            safeHeight = window.safeAreaInsets.bottom
        }
        return safeHeight
    }
    
    static var tabBarHeight: CGFloat {
        return 49 + safeAreaBottomHeight
    }
    
}

class HeadView: BaseView {
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "fanhuibtn"), for: .normal)
        return backBtn
    }()
    
    lazy var namelabel: UILabel = {
        let namelabel = UILabel()
        namelabel.textColor = .white
        namelabel.textAlignment = .center
        namelabel.font = .mediumFontOfSize(size: 18)
        return namelabel
    }()
    
    lazy var lemonView: UIView = {
        let lemonView = UIView()
        lemonView.backgroundColor = .white
        return lemonView
    }()
    
    lazy var addBtn: UIButton = {
        let addBtn = UIButton(type: .custom)
        addBtn.setImage(UIImage(named: "centerlogo"), for: .normal)
        return addBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(lemonView)
        lemonView.addSubview(backBtn)
        lemonView.addSubview(namelabel)
        lemonView.addSubview(addBtn)
        
        lemonView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(StatusBarHeight + 14)
            make.left.equalToSuperview().offset(17)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        namelabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backBtn.snp.centerY)
            make.height.equalTo(30)
        }
        addBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(StatusBarHeight + 14)
            make.right.equalToSuperview().offset(-21)
            make.size.equalTo(CGSize(width: 26, height: 26))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
