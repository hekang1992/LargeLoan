//
//  SubView.swift
//  LargeLoan
//
//  Created by 何康 on 2024/12/15.
//

import UIKit

class HomeSubView: BaseView {
    
    lazy var homeImageView: UIImageView = {
        let homeImageView = UIImageView()
        homeImageView.image = UIImage(named: "homebg")
        homeImageView.isUserInteractionEnabled = true
        return homeImageView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    lazy var bannerImageView: UIImageView = {
        let bannerImageView = UIImageView()
        bannerImageView.isUserInteractionEnabled = true
        bannerImageView.image = UIImage(named: "sublogoban")
        return bannerImageView
    }()

    lazy var applyImageView: UIImageView = {
        let applyImageView = UIImageView()
        applyImageView.isUserInteractionEnabled = true
        applyImageView.image = UIImage(named: "appjiageben")
        return applyImageView
    }()
    
    lazy var descbgImageView: UIImageView = {
        let descbgImageView = UIImageView()
        descbgImageView.isUserInteractionEnabled = true
        descbgImageView.image = UIImage(named: "fullwidth")
        return descbgImageView
    }()
    
    lazy var minscrollView: UIScrollView = {
        let minscrollView = UIScrollView()
        minscrollView.showsVerticalScrollIndicator = false
        minscrollView.showsHorizontalScrollIndicator = false
        minscrollView.contentInsetAdjustmentBehavior = .never
        minscrollView.isPagingEnabled = true
        return minscrollView
    }()
    
    lazy var coponeImageView: UIImageView = {
        let coponeImageView = UIImageView()
        coponeImageView.image = UIImage(named: "Copyone")
        return coponeImageView
    }()
    
    lazy var coptwoImageView: UIImageView = {
        let coptwoImageView = UIImageView()
        coptwoImageView.image = UIImage(named: "Copytwo")
        return coptwoImageView
    }()
    
    lazy var copthreeImageView: UIImageView = {
        let copthreeImageView = UIImageView()
        copthreeImageView.image = UIImage(named: "Copythree")
        return copthreeImageView
    }()
    
    lazy var dexcImageView: UIImageView = {
        let dexcImageView = UIImageView()
        dexcImageView.image = UIImage(named: "Groupdesc")
        return dexcImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(homeImageView)
        addSubview(scrollView)
        scrollView.addSubview(bannerImageView)
        scrollView.addSubview(applyImageView)
        scrollView.addSubview(descbgImageView)
        descbgImageView.addSubview(minscrollView)
        minscrollView.addSubview(coponeImageView)
        minscrollView.addSubview(coptwoImageView)
        minscrollView.addSubview(copthreeImageView)
        descbgImageView.addSubview(dexcImageView)
        homeImageView.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(1091)
        }
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        bannerImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(48)
            make.size.equalTo(CGSize(width: 350, height: 153))
        }
        applyImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bannerImageView.snp.bottom).offset(-44)
            make.size.equalTo(CGSize(width: 392, height: 304))
        }
        descbgImageView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalTo(SCREEN_WIDTH)
            make.top.equalTo(applyImageView.snp.bottom).offset(18)
            make.height.equalTo(579)
            make.bottom.equalToSuperview()
        }
        minscrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(26)
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(SCREEN_WIDTH - 16)
            make.height.equalTo(70)
        }
        coponeImageView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.equalTo(131)
        }
        coptwoImageView.snp.makeConstraints { make in
            make.left.equalTo(coponeImageView.snp.right).offset(10)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(131)
        }
        copthreeImageView.snp.makeConstraints { make in
            make.left.equalTo(coptwoImageView.snp.right).offset(10)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(131)
            make.right.equalToSuperview().offset(-16)
        }
        dexcImageView.snp.makeConstraints { make in
            make.top.equalTo(minscrollView.snp.bottom).offset(18)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 343, height: 371))
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension HomeSubView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
}
