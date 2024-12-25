//
//  ZTViewController.swift
//  LargeLoan
//
//  Created by 何康 on 2024/12/19.
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
        self.headView.bgView.backgroundColor = .clear
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
        
        
        let bgIcon = UIImageView()
        bgIcon.image = UIImage(named: "moneyiamge")
        scrollView.addSubview(bgIcon)
        bgIcon.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 392, height: 225))
        }
        
        let bgView = UIView()
        bgView.backgroundColor = .white
        scrollView.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalTo(SCREEN_WIDTH)
            make.top.equalTo(bgIcon.snp.bottom)
            make.height.equalTo(SCREEN_HEIGHT - 225 - StatusBarHeight - 50)
            make.bottom.equalToSuperview()
        }
        bgView.layoutIfNeeded()
        bgView.setTopCorners(radius: 20)
        
        
        bgView.addSubview(oneSetp)
        bgView.addSubview(twoSetp)
        bgView.addSubview(threeSetp)
        bgView.addSubview(fourSetp)
        bgView.addSubview(fiveSetp)
        
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
        bgView.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.top.equalTo(fiveSetp.snp.bottom).offset(55)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 345, height: 52))
        }
        
        let steps = [oneSetp, twoSetp, threeSetp, fourSetp, fiveSetp]
        
        steps.forEach { [weak self] step in
            guard let self = self else { return }
            step.bgView
                .rx
                .tapGesture()
                .when(.recognized)
                .subscribe(onNext: { _ in
                    let model = self.dataModel.value
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
                        let type = self.model?.exuding.guess?.pungent ?? ""
                        if type >= "solargeg" {
                            let oneVc = AuthYIViewController()
                            oneVc.productID = self.proid
                            self.navigationController?.pushViewController(oneVc, animated: true)
                        }
                        break
                    case self.threeSetp:
                        print("Three step clicked")
                        break
                    case self.fourSetp:
                        print("four step clicked")
                        break
                    case self.fiveSetp:
                        print("five step clicked")
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
            }
        }).disposed(by: disposeBag)
        
    }
    
    
}

extension ZTViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getProductDetailInfo(form: proid ?? "", complete: { [weak self] model in
            self?.typeModel.accept(model)
            self?.getTupuInfo(form: model)
        })
    }
    
    private func getTupuInfo(form model: BaseModel) {
        self.pushVcWithType(model: model)
    }
    
    //状态
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
        }
    }
}


