//
//  LoginView.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/14.
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
    
    lazy var lemonView: UIView = {
        let lemonView = UIView()
        lemonView.backgroundColor = .white
        return lemonView
    }()
    
    lazy var pView: UIView = {
        let pView = UIView()
        pView.layer.cornerRadius = 10
        pView.backgroundColor = .init(colorHexStr: "#FF7F38")?.withAlphaComponent(0.1)
        return pView
    }()
    
    lazy var cView: UIView = {
        let cView = UIView()
        cView.layer.cornerRadius = 10
        cView.backgroundColor = .init(colorHexStr: "#FF7F38")?.withAlphaComponent(0.1)
        return cView
    }()
    
    lazy var bigManLabel: UILabel = {
        let bigManLabel = UILabel()
        bigManLabel.text = "+63"
        bigManLabel.textColor = UIColor.init(colorHexStr: "#2B170A")
        bigManLabel.textAlignment = .center
        bigManLabel.font = .regularFontOfSize(size: 14)
        return bigManLabel
    }()
    
    lazy var phoneTx: UITextField = {
        let phoneTx = UITextField()
        phoneTx.keyboardType = .numberPad
        let attrString = NSMutableAttributedString(string: "Enter your phone number", attributes: [
            .foregroundColor: UIColor.init(colorHexStr: "#2B170A")?.withAlphaComponent(0.5) as Any,
            .font: UIFont.regularFontOfSize(size: 14)
        ])
        phoneTx.attributedPlaceholder = attrString
        phoneTx.font = .regularFontOfSize(size: 14)
        phoneTx.textColor = UIColor.init(colorHexStr: "#2B170A")
        return phoneTx
    }()
    
    lazy var codeTx: UITextField = {
        let codeTx = UITextField()
        codeTx.keyboardType = .numberPad
        let attrString = NSMutableAttributedString(string: "Enter the verification code", attributes: [
            .foregroundColor: UIColor.init(colorHexStr: "#2B170A")?.withAlphaComponent(0.5) as Any,
            .font: UIFont.regularFontOfSize(size: 14)
        ])
        codeTx.attributedPlaceholder = attrString
        codeTx.font = .regularFontOfSize(size: 14)
        codeTx.textColor = UIColor.init(colorHexStr: "#2B170A")
        return codeTx
    }()
    
    lazy var codeBtn: UIButton = {
        let codeBtn = UIButton(type: .custom)
        codeBtn.setTitle("Send code", for: .normal)
        codeBtn.setTitleColor(.white, for: .normal)
        codeBtn.layer.cornerRadius = 10
        codeBtn.backgroundColor = UIColor.init(colorHexStr: "#FF7F38")
        return codeBtn
    }()
    
    lazy var loginBtn: UIButton = {
        let loginBtn = UIButton(type: .custom)
        loginBtn.adjustsImageWhenHighlighted = false
        loginBtn.setImage(UIImage(named: "loginimage"), for: .normal)
        return loginBtn
    }()
    
    lazy var priBtn: UIButton = {
        let priBtn = UIButton(type: .custom)
        priBtn.adjustsImageWhenHighlighted = false
        priBtn.setImage(UIImage(named: "xieyiimage"), for: .selected)
        priBtn.setImage(UIImage(named: "yinsisel"), for: .normal)
        return priBtn
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        return clickBtn
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImage)
        addSubview(lemonView)
        lemonView.addSubview(pView)
        pView.addSubview(bigManLabel)
        pView.addSubview(phoneTx)
        lemonView.addSubview(cView)
        cView.addSubview(codeTx)
        cView.addSubview(codeBtn)
        addSubview(loginBtn)
        addSubview(priBtn)
        priBtn.addSubview(clickBtn)
        bgImage.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(219)
        }
        lemonView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(bgImage.snp.bottom).offset(-20)
        }
        pView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(30)
            make.height.equalTo(50)
        }
        bigManLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(4)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        phoneTx.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.height.equalTo(50)
            make.centerY.equalToSuperview()
            make.left.equalTo(bigManLabel.snp.right)
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
        lemonView.setTopCorners(radius: 20)
    }
    
    func addEnterWord() {
        
        priBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.priBtn.isSelected.toggle()
            if let loginBtn = self?.loginBtn, let priBtn = self?.priBtn {
                loginBtn.isEnabled = !priBtn.isSelected
            }
        }).disposed(by: disposeBag)
        
        phoneTx.rx.controlEvent(.editingChanged)
            .withLatestFrom(phoneTx.rx.text.orEmpty)
            .subscribe(onNext: { [weak self] text in
                guard let self = self else { return }
                self.phoneTx.text = String(text.prefix(15))
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
