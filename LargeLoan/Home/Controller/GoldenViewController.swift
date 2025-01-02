//
//  GoldenViewController.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/26.
//

import UIKit
import RxRelay

class GoldenViewController: BaseViewController {
    
    var productID: String? {
        didSet {
            guard let productID = productID else { return }
        }
    }
    
    lazy var goldenView: UIView = {
        let goldenView = UIView()
        goldenView.backgroundColor = .white
        return goldenView
    }()
    
    lazy var bigManLabel: UILabel = {
        let bigManLabel = UILabel()
        bigManLabel.text = "Withdrawal Method"
        bigManLabel.textColor = UIColor.init(colorHexStr: "#2B170A")
        bigManLabel.textAlignment = .center
        bigManLabel.font = .boldFontOfSize(size: 18)
        return bigManLabel
    }()
    
    lazy var minSoulLabel: UILabel = {
        let minSoulLabel = UILabel()
        minSoulLabel.text = "Please select the most convenient way for you to withdraw"
        minSoulLabel.textColor = UIColor.init(colorHexStr: "#2B170A")
        minSoulLabel.textAlignment = .center
        minSoulLabel.font = .regularFontOfSize(size: 13)
        return minSoulLabel
    }()
    
    lazy var littleLineView: UIView = {
        let littleLineView = UIView()
        littleLineView.backgroundColor = .init(colorHexStr: "#FF7F38")
        return littleLineView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .init(colorHexStr: "#FFFAF1")
        tableView.estimatedRowHeight = 88
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(EnterWordsCell.self, forCellReuseIdentifier: "EnterWordsCell")
        tableView.register(ClockWordsCell.self, forCellReuseIdentifier: "ClockWordsCell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        oneBtn.setTitle("E-wallet", for: .normal)
        oneBtn.titleLabel?.font = .mediumFontOfSize(size: 16)
        oneBtn.setTitleColor(UIColor.init(colorHexStr: "#2B170A"), for: .normal)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        twoBtn.setTitle("Bank", for: .normal)
        twoBtn.titleLabel?.font = .mediumFontOfSize(size: 16)
        twoBtn.setTitleColor(UIColor.init(colorHexStr: "#FFE5D6"), for: .normal)
        return twoBtn
    }()
    
    lazy var lineoView: UIView = {
        let lineoView = UIView()
        lineoView.backgroundColor = .white
        return lineoView
    }()
    
    lazy var linepView: UIView = {
        let linepView = UIView()
        linepView.backgroundColor = .white
        linepView.isHidden = true
        return linepView
    }()
    
    var model = BehaviorRelay<BaseModel?>(value: nil)
    var commonArray = BehaviorRelay<[commonModel]>(value: [])
    var typeInt: Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(homeImageView)
        homeImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backInfo()
        openTime = CurrentTimeManager.getCurrentTime()
        view.addSubview(self.headView)
        self.headView.lemonView.backgroundColor = .clear
        self.headView.namelabel.text = "Withdrawal Info"
        headView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(StatusBarHeight + 50)
        }
        
        view.addSubview(goldenView)
        goldenView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
        
        goldenView.addSubview(bigManLabel)
        goldenView.addSubview(minSoulLabel)
        bigManLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(22)
        }
        minSoulLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bigManLabel.snp.bottom).offset(10)
            make.height.equalTo(16)
        }
        
        
        goldenView.addSubview(littleLineView)
        littleLineView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(minSoulLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(44)
        }
        
        goldenView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.equalTo(littleLineView.snp.left)
            make.top.equalTo(littleLineView.snp.bottom)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
        
        littleLineView.addSubview(oneBtn)
        littleLineView.addSubview(twoBtn)
        littleLineView.addSubview(lineoView)
        littleLineView.addSubview(linepView)
        
        oneBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(55)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 65, height: 19))
        }
        
        twoBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-55)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 65, height: 19))
        }
        lineoView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-0.5)
            make.height.equalTo(4)
            make.left.equalTo(oneBtn.snp.left).offset(5)
            make.width.equalTo(55)
        }
        linepView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-0.5)
            make.height.equalTo(4)
            make.left.equalTo(twoBtn.snp.left).offset(5)
            make.width.equalTo(55)
        }
        
        goldenView.layoutIfNeeded()
        goldenView.setTopCorners(radius: 20)
        littleLineView.setTopCorners(radius: 20)
        
        
        getgoldenInfo()
        
        oneBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.oneBtn.setTitleColor(UIColor(colorHexStr: "#2B170A"), for: .normal)
            self?.twoBtn.setTitleColor(UIColor(colorHexStr: "#FFE5D6"), for: .normal)
            self?.lineoView.isHidden = false
            self?.linepView.isHidden = true
            self?.commonArray.accept(self?.model.value?.exuding.common?.first?.common ?? [])
            self?.typeInt = 1
        }).disposed(by: disposeBag)
        
        twoBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.oneBtn.setTitleColor(UIColor(colorHexStr: "#FFE5D6"), for: .normal)
            self.twoBtn.setTitleColor(UIColor(colorHexStr: "#2B170A"), for: .normal)
            self.lineoView.isHidden = true
            self.linepView.isHidden = false
            self.commonArray.accept(self.model.value?.exuding.common?.last?.common ?? [])
            self.typeInt = 2
        }).disposed(by: disposeBag)
        
        self.commonArray.compactMap { $0 }.asObservable().bind(to: tableView.rx.items) { [weak self] tableView, index, model in
            guard let self = self else { return UITableViewCell() }
            let pill = model.pill ?? ""
            if pill == "solargel" {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "EnterWordsCell", for: IndexPath(row: index, section: 0)) as? EnterWordsCell  {
                    cell.backgroundColor = .clear
                    cell.selectionStyle = .none
                    cell.enterView.bigManLabel.text = model.smile ?? ""
                    cell.enterView.enterTx.placeholder = model.medicine ?? ""
                    cell.enterView.enterTx.text = model.breathing
                    cell.enterView.enterTx.rx.controlEvent(.editingChanged)
                        .withLatestFrom(cell.enterView.enterTx.rx.text.orEmpty)
                        .subscribe(onNext: { text in
                            model.breathing = text
                        })
                        .disposed(by: disposeBag)
                    let nourishing = model.nourishing ?? 0
                    if nourishing == 0 {
                        cell.enterView.enterTx.keyboardType = .default
                    }else {
                        cell.enterView.enterTx.keyboardType = .phonePad
                    }
                    return cell
                }
            }else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "ClockWordsCell", for: IndexPath(row: index, section: 0)) as? ClockWordsCell  {
                    cell.backgroundColor = .clear
                    cell.selectionStyle = .none
                    cell.enterBtnView.bigManLabel.text = model.smile ?? ""
                    cell.enterBtnView.enterTx.placeholder = model.medicine ?? ""
                    cell.enterBtnView.block = { [weak self] btn, tx in
                        self?.tapClick(form: btn, tx: tx, model: model)
                        self?.view.endEditing(true)
                    }
                    cell.enterBtnView.enterTx.text = model.breathing
                    return cell
                }
            }
            return UITableViewCell()
        }.disposed(by: disposeBag)
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension GoldenViewController: UITableViewDelegate {
    
    private func getgoldenInfo() {
        LoadingIndicator.shared.showLoading()
        provider.request(.hqGoldenInfo(sparring: "0", mistake: "app")) { result in
            LoadingIndicator.shared.hideLoading()
            switch result {
            case .success(let response):
                do {
                    let model = try JSONDecoder().decode(BaseModel.self, from: response.data)
                    let anyone = model.anyone
                    if anyone == "0" {
                        self.model.accept(model)
                        self.commonArray.accept(model.exuding.common?.first?.common ?? [])
                    }else {
                        ToastConfig.show(form: self.view, message: model.coldly)
                    }
                } catch {
                    print("JSON: \(error)")
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footView = UIView()
        let nextBtn = UIButton(type: .custom)
        nextBtn.setImage(UIImage(named: "ausubmitimge"), for: .normal)
        footView.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 345, height: 52))
        }
        nextBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            var emptyDict: [String: Any] = [:]
            commonArray.value.forEach { model in
                guard let anyone = model.anyone else { return }
                let value = (model.pill == "solargel" || model.pill == "solargem")
                ? model.breathing
                : model.large
                emptyDict[anyone] = value
            }
            emptyDict["waited"] = "1000459"
            emptyDict["old"] = self.productID ?? ""
            emptyDict["defeated"] = self.typeInt
            self.savegoleeninfo(form: emptyDict)
        }).disposed(by: disposeBag)
        
        return footView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 68
    }
    
    private func tapClick(form btn: UIButton, tx: UITextField, model: commonModel) {
        let pill = model.pill ?? ""
        if pill == "solargek" {
            let modelArray = ClickTypeModel.oneArray(dataArray: model.essence ?? [])
            ShowEnumConfig.popConfig(from: model, tx: tx, dataSource: modelArray, model: .province)
        }
    }
    
    func savegoleeninfo(form emptyDict: [String: Any]){
        closingTime = CurrentTimeManager.getCurrentTime()
        LoadingIndicator.shared.showLoading()
        provider.request(.saveGoldenInfo(emptyDict: emptyDict)) { [weak self] result in
            guard let self = self else { return }
            LoadingIndicator.shared.hideLoading()
            switch result {
            case .success(let response):
                do {
                    let model = try JSONDecoder().decode(BaseModel.self, from: response.data)
                    let anyone = model.anyone
                    if anyone == "0" {
                        self.detailon()
                    }else {
                        ToastConfig.show(form: self.view, message: model.coldly)
                    }
                } catch {
                    print("JSON: \(error)")
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
    private func detailon() {
        self.exprwssinfo()
        self.openNineTime = CurrentTimeManager.getCurrentTime()
        self.getProductDetailInfo(form: self.productID ?? "", complete: { [weak self] model in
            guard let self = self else { return }
            let older = model.exuding.her?.older ?? ""
            if !older.isEmpty {
                self.ddOrderinfo(from: older)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    self.closingNineTime = CurrentTimeManager.getCurrentTime()
                    self.exnineoinnine()
                }
            }
        })
    }
    
    func exprwssinfo() {
        self.expressioninfo(from: self.productID ?? "",
                            continued: "8",
                            openTime: self.openTime,
                            closingTime: self.closingTime)
    }
    
    func exnineoinnine() {
        self.expressioninfo(from: self.productID ?? "",
                            continued: "9",
                            openTime: self.openNineTime,
                            closingTime: self.closingNineTime)
    }
    
}
