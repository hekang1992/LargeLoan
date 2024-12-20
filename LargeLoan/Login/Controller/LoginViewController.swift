//
//  LoginViewController.swift
//  LargeLoan
//
//  Created by 何康 on 2024/12/14.
//

import UIKit
import Toast_Swift

class LoginViewController: BaseViewController {
    
    private var loginView = LoginView()
    
    var count = 60
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tapClick()        
    }
    
}

extension LoginViewController {
    
    func tapClick() {
        
        loginView.codeBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.getcode()
        }).disposed(by: disposeBag)
        
        loginView.loginBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.logoin()
        }).disposed(by: disposeBag)
        
    }
    
    
    func getcode() {
        let phone = self.loginView.phoneTx.text ?? ""
        if phone.isEmpty {
            ToastConfig.show(form: self.view, message: "Please enter your phone number!")
            return
        }
        LoadingIndicator.shared.showLoading()
        provider.request(.tocode(phone: self.loginView.phoneTx.text ?? "")) { [weak self] result in
            LoadingIndicator.shared.hideLoading()
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let model = try JSONDecoder().decode(BaseModel.self, from: response.data)
                    let anyone = model.anyone
                    if anyone == "0" || anyone == "0" {
                        self.loginView.codeBtn.isEnabled = false
                        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(daojishiTime), userInfo: nil, repeats: true)
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
    
    @objc func daojishiTime() {
        if count > 0 {
            count -= 1
            self.loginView.codeBtn.setTitle("\(self.count)s", for: .normal)
        } else {
            enTimer()
        }
    }
    
    func enTimer() {
        timer.invalidate()
        self.loginView.codeBtn.isEnabled = true
        self.loginView.codeBtn.setTitle("Again", for: .normal)
        count = 60
    }
    
    func logoin() {
        let phone = self.loginView.phoneTx.text ?? ""
        if phone.isEmpty {
            ToastConfig.show(form: self.view, message: "Please enter your phone number!")
            return
        }
        LoadingIndicator.shared.showLoading()
        provider.request(.tologin(phone: self.loginView.phoneTx.text ?? "", code: self.loginView.codeTx.text ?? "")) { [weak self] result in
            LoadingIndicator.shared.hideLoading()
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let model = try JSONDecoder().decode(BaseModel.self, from: response.data)
                    let anyone = model.anyone
                    if anyone == "0" || anyone == "0" {
                        LoginFactory.saveLoginInfo(one: model.exuding.surroundings ?? "", two: model.exuding.nonstop ?? "")
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
