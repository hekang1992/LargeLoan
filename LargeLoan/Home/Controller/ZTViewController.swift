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
    
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    lazy var oneSetp: StepView = {
        let oneSetp = StepView()
        oneSetp.licon.image = UIImage(named: "dunpaiimage")
        oneSetp.mlabel.text = "Verify Identity"
        return oneSetp
    }()
    
    lazy var twoSetp: StepView = {
        let twoSetp = StepView()
        twoSetp.licon.image = UIImage(named: "sheimage")
        twoSetp.mlabel.text = "Personal Information"
        return twoSetp
    }()
    
    lazy var threeSetp: StepView = {
        let threeSetp = StepView()
        threeSetp.licon.image = UIImage(named: "dagongzhaiimge")
        threeSetp.mlabel.text = "Work Information"
        return threeSetp
    }()
    
    lazy var fourSetp: StepView = {
        let fourSetp = StepView()
        fourSetp.licon.image = UIImage(named: "phoneiamgea")
        fourSetp.mlabel.text = "Contact Information"
        return fourSetp
    }()
    
    lazy var fiveSetp: StepView = {
        let fiveSetp = StepView()
        fiveSetp.licon.image = UIImage(named: "qiongbibank")
        fiveSetp.mlabel.text = "Bank Card Info"
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
                                
                            }
                        }
                        break
                    case self.twoSetp:
                        print("Two step clicked")
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
        
        if let model = self.model {
            self.getTupuInfo(form: model)
        }
        
    }
    
    
}

extension ZTViewController {
    
    private func getTupuInfo(form model: BaseModel) {
        self.pushVcWithType(model: model)
    }
    
    func pushVcWithType(model: BaseModel) {
        let type = model.exuding.guess?.pungent ?? ""
        if type == "solargef" {
            allowEnter(from: model.exuding.her?.digging ?? "")
        }else {
            
        }
    }
    
    private func allowEnter(from old: String) {
        LoadingIndicator.shared.showLoading()
        provider.request(.southern(old: old)) { [weak self] result in
            LoadingIndicator.shared.hideLoading()
            switch result {
            case .success(let response):
                do {
                    let model = try JSONDecoder().decode(BaseModel.self, from: response.data)
                    let anyone = model.anyone
                    if anyone == "0" || anyone == "0" {
                        self?.dataModel.accept(model)
                    }
                } catch {
                    print("JSON: \(error)")
                }
            case .failure(_):
                break
            }
        }
    }
    
//    listimagebg
    
}


