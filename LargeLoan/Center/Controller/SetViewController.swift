//
//  SetViewController.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/15.
//

import UIKit
import TYAlertController

class SetViewController: BaseViewController {
    
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
        vlabel.textColor = UIColor.init(colorHexStr: "#101D37")
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
        backInfo()
        homeImageView.addSubview(self.headView)
        self.headView.namelabel.text = "Set Up"
        self.headView.lemonView.backgroundColor = .clear
        headView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(StatusBarHeight + 50)
        }
        
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
        
        logoutBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.log()
        }).disposed(by: disposeBag)
        
        delBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.del()
        }).disposed(by: disposeBag)
        
        
    }
    


}

extension SetViewController {
    
    func log() {
        let logoutView = LogoutView(frame: self.view.bounds)
        ShowalertConfig.alertShow(form: logoutView, vc: self)
        logoutView.oneBtn.rx.tap.subscribe(onNext: {
            self.dismiss(animated: true)
        }).disposed(by: disposeBag)
        logoutView.twoBtn.rx.tap.subscribe(onNext: {
            self.dismiss(animated: true)
        }).disposed(by: disposeBag)
        logoutView.threeBtn.rx.tap.subscribe(onNext: {
            self.dismiss(animated: true) {
                self.out()
            }
        }).disposed(by: disposeBag)
    }
    
    func del() {
        let logoutView = DelInfoView(frame: self.view.bounds)
        ShowalertConfig.alertShow(form: logoutView, vc: self)
        logoutView.oneBtn.rx.tap.subscribe(onNext: {
            self.dismiss(animated: true)
        }).disposed(by: disposeBag)
        logoutView.twoBtn.rx.tap.subscribe(onNext: {
            self.dismiss(animated: true)
        }).disposed(by: disposeBag)
        logoutView.threeBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            if logoutView.priBtn.isSelected {
                self.dismiss(animated: true) {
                    self.oiont()
                }
            }else {
                ToastConfig.show(form: logoutView, message: "Please review and confirm the agreement before deciding whether to delete the account.")
            }
        }).disposed(by: disposeBag)
        
        logoutView.priBtn.rx.tap.subscribe(onNext: {
            logoutView.priBtn.isSelected.toggle()
        }).disposed(by: disposeBag)
        
    }
    
    func out() {
        LoadingIndicator.shared.showLoading()
        provider.request(.tologOut) { [weak self] result in
            LoadingIndicator.shared.hideLoading()
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let model = try JSONDecoder().decode(BaseModel.self, from: response.data)
                    let anyone = model.anyone
                    if anyone == "0" {
                        LoginFactory.removeLoginInfo()
                        PushRootVcConfig.goRootVc()
                    }
                    ToastConfig.show(form: view, message: model.coldly)
                } catch {
                    print("JSON: \(error)")
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
    func oiont() {
        LoadingIndicator.shared.showLoading()
        provider.request(.todeleinfo) { [weak self] result in
            LoadingIndicator.shared.hideLoading()
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let model = try JSONDecoder().decode(BaseModel.self, from: response.data)
                    let anyone = model.anyone
                    if anyone == "0" {
                        LoginFactory.removeLoginInfo()
                        PushRootVcConfig.goRootVc()
                    }
                    ToastConfig.show(form: view, message: model.coldly)
                } catch {
                    print("JSON: \(error)")
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
}




class LogoutView: BaseView {
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.isUserInteractionEnabled = true
        bgImageView.image = UIImage(named: "logoutimgefad")
        return bgImageView
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        return twoBtn
    }()
    
    lazy var threeBtn: UIButton = {
        let threeBtn = UIButton(type: .custom)
        return threeBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(oneBtn)
        bgImageView.addSubview(twoBtn)
        bgImageView.addSubview(threeBtn)
        
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 303, height: 282))
        }
        oneBtn.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        twoBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(148)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(48)
        }
        threeBtn.snp.makeConstraints { make in
            make.top.equalTo(twoBtn.snp.bottom).offset(18)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(48)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class DelInfoView: BaseView {
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.isUserInteractionEnabled = true
        bgImageView.image = UIImage(named: "deleimgeino")
        return bgImageView
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        twoBtn.setImage(UIImage(named: "bushace"), for: .normal)
        return twoBtn
    }()
    
    lazy var threeBtn: UIButton = {
        let threeBtn = UIButton(type: .custom)
        threeBtn.setImage(UIImage(named: "querenshan"), for: .normal)
        return threeBtn
    }()
    
    lazy var priBtn: UIButton = {
        let priBtn = UIButton(type: .custom)
        priBtn.setImage(UIImage(named: "noesef"), for: .normal)
        priBtn.setImage(UIImage(named: "selimagedelas"), for: .selected)
        return priBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(oneBtn)
        bgImageView.addSubview(twoBtn)
        bgImageView.addSubview(threeBtn)
        bgImageView.addSubview(priBtn)
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 315, height: 370))
        }
        oneBtn.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        twoBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(193)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 271, height: 48))
        }
        threeBtn.snp.makeConstraints { make in
            make.top.equalTo(twoBtn.snp.bottom).offset(18)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 271, height: 48))
        }
        priBtn.snp.makeConstraints { make in
            make.top.equalTo(threeBtn.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 238, height: 18))
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




