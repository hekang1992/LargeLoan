//
//  ZTViewController.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/19.
//

import UIKit
import RxRelay

class ZTViewController: BaseViewController {
    
    var model: BaseModel? {
        didSet {
            guard let model = model else { return }
            print("model======\(model.exuding.guess?.pungent ?? "")")
        }
    }
    
    var proid: String? {
        didSet {
            guard let proid = proid else { return }
            print("proid======\(proid)")
        }
    }
    
    var typeModel = BehaviorRelay<BaseModel?>(value: nil)
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    lazy var oneSetp: StepView = {
        let oneSetp = StepView()
        oneSetp.licon.image = UIImage(named: "dunpaiimage")
        oneSetp.bigManLabel.text = "Verify Identity"
        return oneSetp
    }()
    
    lazy var twoSetp: StepView = {
        let twoSetp = StepView()
        twoSetp.licon.image = UIImage(named: "sheimage")
        twoSetp.bigManLabel.text = "Personal Information"
        return twoSetp
    }()
    
    lazy var threeSetp: StepView = {
        let threeSetp = StepView()
        threeSetp.licon.image = UIImage(named: "dagongzhaiimge")
        threeSetp.bigManLabel.text = "Work Information"
        return threeSetp
    }()
    
    lazy var fourSetp: StepView = {
        let fourSetp = StepView()
        fourSetp.licon.image = UIImage(named: "phoneiamgea")
        fourSetp.bigManLabel.text = "Contact Information"
        return fourSetp
    }()
    
    lazy var fiveSetp: StepView = {
        let fiveSetp = StepView()
        fiveSetp.licon.image = UIImage(named: "qiongbibank")
        fiveSetp.bigManLabel.text = "Bank Card Info"
        return fiveSetp
    }()
    
    var dataModel = BehaviorRelay<BaseModel?>(value: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        view.addSubview(homeImageView)
        homeImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(self.headView)
        self.headView.lemonView.backgroundColor = .clear
        self.headView.namelabel.text = "Verify Step"
        headView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(StatusBarHeight + 50)
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(headView.snp.bottom)
        }
        
        self.headView.backBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }).disposed(by: disposeBag)
        
        let bgIcon = UIImageView()
        bgIcon.image = UIImage(named: "moneyiamge")
        scrollView.addSubview(bgIcon)
        bgIcon.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 392, height: 225))
        }
        
        let lemonView = UIView()
        lemonView.backgroundColor = .white
        scrollView.addSubview(lemonView)
        lemonView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalTo(SCREEN_WIDTH)
            make.top.equalTo(bgIcon.snp.bottom)
            make.height.equalTo(SCREEN_HEIGHT - 225 - StatusBarHeight - 50)
            make.bottom.equalToSuperview()
        }
        lemonView.layoutIfNeeded()
        lemonView.setTopCorners(radius: 20)
        
        
        lemonView.addSubview(oneSetp)
        lemonView.addSubview(twoSetp)
        lemonView.addSubview(threeSetp)
        lemonView.addSubview(fourSetp)
        lemonView.addSubview(fiveSetp)
        
        oneSetp.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview()
            make.height.equalTo(60)
        }
        
        twoSetp.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(oneSetp.snp.bottom).offset(20)
            make.left.equalToSuperview()
            make.height.equalTo(60)
        }
        
        threeSetp.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(twoSetp.snp.bottom).offset(20)
            make.left.equalToSuperview()
            make.height.equalTo(60)
        }
        
        fourSetp.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(threeSetp.snp.bottom).offset(20)
            make.left.equalToSuperview()
            make.height.equalTo(60)
        }
        
        fiveSetp.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(fourSetp.snp.bottom).offset(20)
            make.left.equalToSuperview()
            make.height.equalTo(60)
        }
        
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "nextimagep"), for: .normal)
        lemonView.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.top.equalTo(fiveSetp.snp.bottom).offset(55)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 345, height: 52))
        }
        
        let steps = [oneSetp, twoSetp, threeSetp, fourSetp, fiveSetp]
        
        steps.forEach { [weak self] step in
            guard let self = self else { return }
            step.lemonView
                .rx
                .tapGesture()
                .when(.recognized)
                .subscribe(onNext: { _ in
                    let model = self.dataModel.value
                    let type = self.typeModel.value?.exuding.guess?.pungent ?? ""
                    switch step {
                    case self.oneSetp:
                        if let smiled = model?.exuding.smiled, let ever = smiled.ever {
                            if ever == 0 {
                                let listVc = KFCViewController()
                                listVc.array = model?.exuding.big
                                listVc.productID = self.proid
                                self.navigationController?.pushViewController(listVc, animated: true)
                            }else {
                                let faceVc = FaceViewController()
                                faceVc.productID = self.proid
                                self.navigationController?.pushViewController(faceVc, animated: true)
                            }
                        }else {
                            let phoVc = PhotoViewController()
                            phoVc.productID = self.proid
                            self.navigationController?.pushViewController(phoVc, animated: true)
                        }
                        break
                    case self.twoSetp:
                        if type >= "solargeg" {
                            let oneVc = AuthYIViewController()
                            oneVc.productID = self.proid
                            self.navigationController?.pushViewController(oneVc, animated: true)
                        }else {
                            if type.isEmpty {
                                let oneVc = AuthYIViewController()
                                oneVc.productID = self.proid
                                self.navigationController?.pushViewController(oneVc, animated: true)
                            }else {
                                self.toasVcinfo()
                            }
                        }
                        break
                    case self.threeSetp:
                        if type >= "solargeh" {
                            let twoVc = AVTEViewController()
                            twoVc.productID = self.proid
                            self.navigationController?.pushViewController(twoVc, animated: true)
                        }else {
                            if type.isEmpty {
                                let twoVc = AVTEViewController()
                                twoVc.productID = self.proid
                                self.navigationController?.pushViewController(twoVc, animated: true)
                            }else {
                                self.toasVcinfo()
                            }
                        }
                        break
                    case self.fourSetp:
                        if type >= "solargei" {
                            let threeVc = ConLULUlemonViewController()
                            threeVc.productID = self.proid
                            self.navigationController?.pushViewController(threeVc, animated: true)
                        }else {
                            if type.isEmpty {
                                let threeVc = ConLULUlemonViewController()
                                threeVc.productID = self.proid
                                self.navigationController?.pushViewController(threeVc, animated: true)
                            }else {
                                self.toasVcinfo()
                            }
                        }
                        break
                    case self.fiveSetp:
                        if type >= "solargej" {
                            let fourVc = GoldenViewController()
                            fourVc.productID = self.proid
                            self.navigationController?.pushViewController(fourVc, animated: true)
                        }else {
                            if type.isEmpty {
                                let fourVc = GoldenViewController()
                                fourVc.productID = self.proid
                                self.navigationController?.pushViewController(fourVc, animated: true)
                            }else {
                                self.toasVcinfo()
                            }
                        }
                        break
                    default:
                        break
                    }
                }).disposed(by: disposeBag)
            
        }

        btn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self, let model = self.typeModel.value, let type = model.exuding.guess?.pungent else { return }
            if type == "solargef" {
                let dataModel = self.dataModel.value
                if let smiled = dataModel?.exuding.smiled, let ever = smiled.ever {
                    if ever == 0 {
                        let listVc = KFCViewController()
                        listVc.array = dataModel?.exuding.big
                        listVc.productID = self.proid
                        self.navigationController?.pushViewController(listVc, animated: true)
                    }else {
                        let faceVc = FaceViewController()
                        faceVc.productID = self.proid
                        self.navigationController?.pushViewController(faceVc, animated: true)
                    }
                }
            }else if type == "solargeg" {
                let oneVc = AuthYIViewController()
                oneVc.productID = self.proid
                self.navigationController?.pushViewController(oneVc, animated: true)
            }else if type == "solargeh" {
                let oneVc = AVTEViewController()
                oneVc.productID = self.proid
                self.navigationController?.pushViewController(oneVc, animated: true)
            }else if type == "solargei" {
                let oneVc = ConLULUlemonViewController()
                oneVc.productID = self.proid
                self.navigationController?.pushViewController(oneVc, animated: true)
            }else if type == "solargej"{
                let oneVc = GoldenViewController()
                oneVc.productID = self.proid
                self.navigationController?.pushViewController(oneVc, animated: true)
            }else {
                let oneVc = GoldenViewController()
                oneVc.productID = self.proid
                self.navigationController?.pushViewController(oneVc, animated: true)
            }
        }).disposed(by: disposeBag)
        
    }
    
    private func toasVcinfo() {
        ToastConfig.show(form: self.view, message: "Kindly finalize the prior authentication procedure before proceeding.")
    }
    
    
}

extension ZTViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getProductDetailInfo(form: proid ?? "", complete: { [weak self] model, str in
            self?.typeModel.accept(model)
            self?.getTupuInfo(form: model)
        })
    }
    
    private func getTupuInfo(form model: BaseModel) {
        self.pushVcWithType(model: model)
    }
    
    func pushVcWithType(model: BaseModel) {
        let type = model.exuding.guess?.pungent ?? ""
        if type == "solargef" {
            allowEnter(from: model.exuding.her?.digging ?? "", complete: { model in
                self.dataModel.accept(model)
            })
        }else if type == "solargeg" {
            self.oneSetp.ricon.image = UIImage(named: "vselimage")
        }else if type == "solargeh" {
            self.oneSetp.ricon.image = UIImage(named: "vselimage")
            self.twoSetp.ricon.image = UIImage(named: "vselimage")
        }else if type == "solargei" {
            self.oneSetp.ricon.image = UIImage(named: "vselimage")
            self.twoSetp.ricon.image = UIImage(named: "vselimage")
            self.threeSetp.ricon.image = UIImage(named: "vselimage")
        }else if type == "solargej" {
            self.oneSetp.ricon.image = UIImage(named: "vselimage")
            self.twoSetp.ricon.image = UIImage(named: "vselimage")
            self.threeSetp.ricon.image = UIImage(named: "vselimage")
            self.fourSetp.ricon.image = UIImage(named: "vselimage")
        }else {
            self.oneSetp.ricon.image = UIImage(named: "vselimage")
            self.twoSetp.ricon.image = UIImage(named: "vselimage")
            self.threeSetp.ricon.image = UIImage(named: "vselimage")
            self.fourSetp.ricon.image = UIImage(named: "vselimage")
            self.fiveSetp.ricon.image = UIImage(named: "vselimage")
        }
    }
}


