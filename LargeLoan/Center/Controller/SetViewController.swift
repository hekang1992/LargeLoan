//
//  SetViewController.swift
//  LargeLoan
//
//  Created by 何康 on 2024/12/15.
//

import UIKit

class SetViewController: BaseViewController {
    
    lazy var homeImageView: UIImageView = {
        let homeImageView = UIImageView()
        homeImageView.image = UIImage(named: "homebg")
        homeImageView.isUserInteractionEnabled = true
        return homeImageView
    }()
    
    lazy var jImageView: UIImageView = {
        let jImageView = UIImageView()
        jImageView.image = UIImage(named: "jianbainsebg")
        return jImageView
    }()
    
    lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        return whiteView
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "centerlogo")
        return iconImageView
    }()
    
    lazy var vlabel: UILabel = {
        let vlabel = UILabel()
        vlabel.text = "Version 1.0.0"
        vlabel.textColor = UIColor.init(cssStr: "#101D37")
        vlabel.textAlignment = .center
        vlabel.font = .regularFontOfSize(size: 16)
        return vlabel
    }()
    
    lazy var logoutBtn: UIButton = {
        let logoutBtn = UIButton(type: .custom)
        logoutBtn.setImage(UIImage(named: "logoutimge"), for: .normal)
        return logoutBtn
    }()
    
    lazy var delBtn: UIButton = {
        let delBtn = UIButton(type: .custom)
        delBtn.setImage(UIImage(named: "deleteimage"), for: .normal)
        return delBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(homeImageView)
        homeImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        homeImageView.addSubview(self.headView)
        self.headView.namelabel.text = "Set Up"
        self.headView.bgView.backgroundColor = .clear
        headView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(StatusBarHeight + 50)
        }
        
        backInfo()
        
        homeImageView.addSubview(jImageView)
        jImageView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(27)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(62)
        }
        
        homeImageView.addSubview(whiteView)
        whiteView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(jImageView.snp.top).offset(36)
        }
        whiteView.layoutIfNeeded()
        whiteView.setTopCorners(radius: 20)

        
        whiteView.addSubview(iconImageView)
        
        whiteView.addSubview(vlabel)
        
        iconImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 129, height: 129))
        }
        
        vlabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(19)
        }
        
        whiteView.addSubview(logoutBtn)
        whiteView.addSubview(delBtn)
        
        
        logoutBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 343, height: 60))
            make.top.equalTo(iconImageView.snp.bottom).offset(63)
        }
        
        delBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 343, height: 60))
            make.top.equalTo(logoutBtn.snp.bottom).offset(10)
        }
    }
    


}

extension SetViewController {
    
    
    
}
