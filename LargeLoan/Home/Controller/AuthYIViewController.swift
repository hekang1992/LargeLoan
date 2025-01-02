//
//  AuthYIViewController.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/23.
//

import UIKit
import RxRelay
import BRPickerView

class AuthYIViewController: BaseViewController {
    
    var productID: String? {
        didSet {
            guard let productID = productID else { return }
        }
    }
    
    lazy var lemonView: UIView = {
        let lemonView = UIView()
        lemonView.backgroundColor = .white
        return lemonView
    }()
    
    lazy var bigManLabel: UILabel = {
        let bigManLabel = UILabel()
        bigManLabel.text = "Personal Information"
        bigManLabel.textColor = UIColor.init(colorHexStr: "#2B170A")
        bigManLabel.textAlignment = .center
        bigManLabel.font = .boldFontOfSize(size: 18)
        return bigManLabel
    }()
    
    lazy var minSoulLabel: UILabel = {
        let minSoulLabel = UILabel()
        minSoulLabel.text = "Please fill in your real name information"
        minSoulLabel.textColor = UIColor.init(colorHexStr: "#2B170A")
        minSoulLabel.textAlignment = .center
        minSoulLabel.font = .regularFontOfSize(size: 13)
        return minSoulLabel
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .init(colorHexStr: "#FFDFCA")
        tableView.estimatedRowHeight = 88
        tableView.separatorStyle = .none
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
    
    var model = BehaviorRelay<BaseModel?>(value: nil)
    var modelArray = BehaviorRelay<[commonModel]?>(value: nil)
    var regionArray = BehaviorRelay<[BRProvinceModel]?>(value: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(homeImageView)
        homeImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backInfo()
        view.addSubview(self.headView)
        self.headView.lemonView.backgroundColor = .clear
        self.headView.namelabel.text = "Personal Information"
        headView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(StatusBarHeight + 50)
        }
        
        view.addSubview(lemonView)
        lemonView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
        lemonView.layoutIfNeeded()
        lemonView.setTopCorners(radius: 20)
        
        
        lemonView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        getTeoInfo()
        
        model.asObservable().subscribe(onNext: { [weak self] model in
            if let self = self, let model = model {
                self.modelArray.accept(model.exuding.common ?? [])
            }
        }).disposed(by: disposeBag)
        
        self.modelArray.compactMap { $0 }.asObservable().bind(to: tableView.rx.items) { [weak self] tableView, index, model in
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
        
        
        openTime = CurrentTimeManager.getCurrentTime()
        
    }
    
}


extension AuthYIViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let lemonView = UIView()
        lemonView.backgroundColor = .white
        lemonView.addSubview(bigManLabel)
        lemonView.addSubview(minSoulLabel)
        
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
        return lemonView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
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
            guard let self = self, let modelArray = self.modelArray.value else { return }
            var emptyDict: [String: Any] = [:]
            modelArray.forEach { model in
                guard let anyone = model.anyone else { return }
                let value = (model.pill == "solargel" || model.pill == "solargem")
                ? model.breathing
                : model.large
                emptyDict[anyone] = value
            }
            emptyDict["heavily"] = "c4"
            emptyDict["old"] = self.productID ?? ""
            self.sumothing(from: emptyDict)
        }).disposed(by: disposeBag)
        
        return footView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 68
    }
    
    func getTeoInfo() {
        LoadingIndicator.shared.showLoading()
        provider.request(.getTwoInfo(old: productID ?? "")) { result in
            LoadingIndicator.shared.hideLoading()
            switch result {
            case .success(let response):
                do {
                    let model = try JSONDecoder().decode(BaseModel.self, from: response.data)
                    let anyone = model.anyone
                    if anyone == "0" {
                        self.model.accept(model)
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
    
    private func tapClick(form btn: UIButton, tx: UITextField, model: commonModel) {
        let pill = model.pill ?? ""
        if pill == "solargek" {
            let modelArray = ClickTypeModel.oneArray(dataArray: model.essence ?? [])
            ShowEnumConfig.popConfig(from: model, tx: tx, dataSource: modelArray, model: .province)
        } else if pill == "solargem" {
            self.regionArray.asObservable().subscribe(onNext: { [weak self] modelArray in
                guard let self = self, let modelArray = modelArray, modelArray.count > 0 else {
                    self?.getCinof()
                    return
                }
                ShowEnumConfig.popConfig(from: model, tx: tx, dataSource: modelArray, model: .area)
            }).disposed(by: disposeBag)
        }
    }
    
}

extension AuthYIViewController {
    
    private func getCinof() {
        LoadingIndicator.shared.showLoading()
        provider.request(.getRegion) { result in
            LoadingIndicator.shared.hideLoading()
            switch result {
            case .success(let response):
                do {
                    let model = try JSONDecoder().decode(BaseModel.self, from: response.data)
                    let anyone = model.anyone
                    if anyone == "0" {
                        if let modelArray = model.exuding.region {
                            let regionArray = ClickTypeModel.threeArray(dataArr: modelArray)
                            self.regionArray.accept(regionArray)
                            print("=======")
                        }
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
    
    func sumothing(from emptyDict: [String: Any]) {
        LoadingIndicator.shared.showLoading()
        provider.request(.saveTPinfo(emptyDict: emptyDict)) { [weak self] result in
            LoadingIndicator.shared.hideLoading()
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let model = try JSONDecoder().decode(BaseModel.self, from: response.data)
                    let anyone = model.anyone
                    if anyone == "0" {
                        self.getPD()
                    }else {
                        ToastConfig.show(form: view, message: model.coldly)
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
    
    private func getPD() {
        self.getProductDetailInfo(form: self.productID ?? "") { [weak self] model in
            guard let self = self else { return }
            let type = model.exuding.guess?.pungent ?? ""
            ConLULULemonCong.tpuType(from: type, old: self.productID ?? "", vc: self)
        }
        closingTime = CurrentTimeManager.getCurrentTime()
        self.exprwssinfo()
    }
    
    func exprwssinfo() {
        self.expressioninfo(from: self.productID ?? "",
                            continued: "5",
                            openTime: self.openTime,
                            closingTime: self.closingTime)
    }
    
}
