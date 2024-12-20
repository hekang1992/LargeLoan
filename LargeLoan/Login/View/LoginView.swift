//
//  LoginView.swift
//  LargeLoan
//
//  Created by 何康 on 2024/12/14.
//

import UIKit
import RxSwift
import RxGesture

class LoginView: BaseView {
    
    lazy var bgImage: UIImageView = {
        let bgImage = UIImageView()
        bgImage.image = UIImage(named: "banner")
        return bgImage
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        return bgView
    }()
    
    lazy var pView: UIView = {
        let pView = UIView()
        pView.layer.cornerRadius = 10
        pView.backgroundColor = .init(cssStr: "#FF7F38")?.withAlphaComponent(0.1)
        return pView
    }()
    
    lazy var cView: UIView = {
        let cView = UIView()
        cView.layer.cornerRadius = 10
        cView.backgroundColor = .init(cssStr: "#FF7F38")?.withAlphaComponent(0.1)
        return cView
    }()
    
    lazy var mlabel: UILabel = {
        let mlabel = UILabel()
        mlabel.text = "+63"
        mlabel.textColor = UIColor.init(cssStr: "#2B170A")
        mlabel.textAlignment = .center
        mlabel.font = .regularFontOfSize(size: 14)
        return mlabel
    }()
    
    lazy var phoneTx: UITextField = {
        let phoneTx = UITextField()
        phoneTx.keyboardType = .numberPad
        let attrString = NSMutableAttributedString(string: "Enter your cellphone number", attributes: [
            .foregroundColor: UIColor.init(cssStr: "#2B170A")?.withAlphaComponent(0.5) as Any,
            .font: UIFont.regularFontOfSize(size: 14)
        ])
        phoneTx.attributedPlaceholder = attrString
        phoneTx.font = .regularFontOfSize(size: 14)
        phoneTx.textColor = UIColor.init(cssStr: "#2B170A")
        return phoneTx
    }()
    
    lazy var codeTx: UITextField = {
        let codeTx = UITextField()
        codeTx.keyboardType = .numberPad
        let attrString = NSMutableAttributedString(string: "Enter the confirmation code", attributes: [
            .foregroundColor: UIColor.init(cssStr: "#2B170A")?.withAlphaComponent(0.5) as Any,
            .font: UIFont.regularFontOfSize(size: 14)
        ])
        codeTx.attributedPlaceholder = attrString
        codeTx.font = .regularFontOfSize(size: 14)
        codeTx.textColor = UIColor.init(cssStr: "#2B170A")
        return codeTx
    }()
    
    lazy var codeBtn: UIButton = {
        let codeBtn = UIButton(type: .custom)
        codeBtn.setTitle("Get code", for: .normal)
        codeBtn.setTitleColor(.white, for: .normal)
        codeBtn.layer.cornerRadius = 10
        codeBtn.backgroundColor = UIColor.init(cssStr: "#FF7F38")
        return codeBtn
    }()
    
    lazy var loginBtn: UIButton = {
        let loginBtn = UIButton(type: .custom)
        loginBtn.isEnabled = false
        loginBtn.adjustsImageWhenHighlighted = false
        loginBtn.setImage(UIImage(named: "loginimage"), for: .normal)
        return loginBtn
    }()
    
    lazy var priBtn: UIButton = {
        let priBtn = UIButton(type: .custom)
        priBtn.adjustsImageWhenHighlighted = false
        priBtn.setImage(UIImage(named: "xieyiimage"), for: .normal)
        priBtn.setImage(UIImage(named: "yinsisel"), for: .selected)
        return priBtn
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        return clickBtn
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImage)
        addSubview(bgView)
        bgView.addSubview(pView)
        pView.addSubview(mlabel)
        pView.addSubview(phoneTx)
        bgView.addSubview(cView)
        cView.addSubview(codeTx)
        cView.addSubview(codeBtn)
        addSubview(loginBtn)
        addSubview(priBtn)
        priBtn.addSubview(clickBtn)
        bgImage.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(219)
        }
        bgView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(bgImage.snp.bottom).offset(-20)
        }
        pView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(30)
            make.height.equalTo(50)
        }
        mlabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(4)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        phoneTx.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.height.equalTo(50)
            make.centerY.equalToSuperview()
            make.left.equalTo(mlabel.snp.right)
        }
        cView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(pView.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        codeTx.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(14)
            make.height.equalTo(50)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-90)
        }
        codeBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(40)
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
        }
        loginBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 344, height: 48))
            make.top.equalTo(cView.snp.bottom).offset(45)
        }
        priBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 243, height: 24))
            make.bottom.equalToSuperview().offset(-54)
        }
        clickBtn.snp.makeConstraints { make in
            make.top.bottom.right.equalToSuperview()
            make.width.equalTo(120)
        }
        addEnterWord()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension LoginView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.setTopCorners(radius: 20)
    }
    
    func addEnterWord() {
        
        clickBtn.rx.tap.subscribe(onNext: { [weak self] in
            print("隐私协议点击=========")
        }).disposed(by: disposeBag)
        
        priBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.priBtn.isSelected.toggle()
            if let loginBtn = self?.loginBtn, let priBtn = self?.priBtn {
                loginBtn.isEnabled = priBtn.isSelected
            }
        }).disposed(by: disposeBag)
        
        phoneTx.rx.text
            .orEmpty
            .map { text in
                let limitedText = String(text.prefix(11))
                return (limitedText, limitedText.count >= 11)
            }
            .distinctUntilChanged { $0.0 == $1.0 }
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] (text, isExceeded) in
                guard let self = self else { return }
                self.phoneTx.text = text
                if isExceeded {
                    self.phoneTx.resignFirstResponder()
                }
            })
            .disposed(by: disposeBag)
        
        phoneTx.rx.controlEvent(.editingChanged)
            .withLatestFrom(phoneTx.rx.text.orEmpty)
            .subscribe(onNext: { [weak self] text in
                guard let self = self else { return }
                if text.count > 11 {
                    self.phoneTx.text = String(text.prefix(11))
                }
            })
            .disposed(by: disposeBag)
        
        
        codeTx.rx.text
            .orEmpty
            .map { text in
                let limitedText = String(text.prefix(6))
                return (limitedText, limitedText.count >= 6)
            }
            .distinctUntilChanged { $0.0 == $1.0 }
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] (text, isExceeded) in
                guard let self = self else { return }
                self.codeTx.text = text
                if isExceeded {
                    self.codeTx.resignFirstResponder()
                }
            })
            .disposed(by: disposeBag)
        
        codeTx.rx.controlEvent(.editingChanged)
            .withLatestFrom(codeTx.rx.text.orEmpty)
            .subscribe(onNext: { [weak self] text in
                guard let self = self else { return }
                if text.count > 6 {
                    self.codeTx.text = String(text.prefix(6))
                }
            })
            .disposed(by: disposeBag)
        
    }
    
}
