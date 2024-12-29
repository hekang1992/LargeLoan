//
//  ConLULUlemonViewController.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/25.
//


import UIKit
import RxRelay
import ContactsUI
import BRPickerView

class ConLULUlemonViewController: BaseViewController {
    
    var productID: String? {
        didSet {
            guard let productID = productID else { return }
            print("photo====productID======\(productID)")
        }
    }
    
    lazy var lemonView: UIView = {
        let lemonView = UIView()
        lemonView.backgroundColor = .white
        return lemonView
    }()
    
    lazy var bigManLabel: UILabel = {
        let bigManLabel = UILabel()
        bigManLabel.text = "Contact Information"
        bigManLabel.textColor = UIColor.init(cssStr: "#2B170A")
        bigManLabel.textAlignment = .center
        bigManLabel.font = .boldFontOfSize(size: 18)
        return bigManLabel
    }()
    
    lazy var minSoulLabel: UILabel = {
        let minSoulLabel = UILabel()
        minSoulLabel.text = "Please fill in emergency contact information"
        minSoulLabel.textColor = UIColor.init(cssStr: "#2B170A")
        minSoulLabel.textAlignment = .center
        minSoulLabel.font = .regularFontOfSize(size: 13)
        return minSoulLabel
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .init(cssStr: "#FFDFCA")
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(ConLULULemonCongTableViewCell.self, forCellReuseIdentifier: "ConLULULemonCongTableViewCell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    var modelArray = BehaviorRelay<[letModel]?>(value: nil)
    
    var uploadBool: Bool = false
    
    var tx = UITextField()
    
    var model = letModel()
    
    lazy var contactPicker: CNContactPickerViewController = {
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        return contactPicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(homeImageView)
        homeImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(self.headView)
        self.headView.lemonView.backgroundColor = .clear
        self.headView.namelabel.text = "Contact Information"
        headView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(StatusBarHeight + 50)
        }
        openTime = CurrentTimeManager.getCurrentTime()
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
        
        gellmeonInfo()
    }
    
}


extension ConLULUlemonViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 264
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConLULULemonCongTableViewCell", for: indexPath) as? ConLULULemonCongTableViewCell
        cell?.backgroundColor = .clear
        cell?.selectionStyle = .none
        let model = self.modelArray.value?[indexPath.row]
        cell?.model.accept(model)
        cell?.oneblock = { tx in
            if let model = model {
                let modelArray = ClickTypeModel.oneArray(dataArray: model.normal ?? [])
                ShowEnumConfig.popPhoneConfig(from: model, tx: tx, dataSource: modelArray, model: .province)
            }
        }
        cell?.twoblock = { [weak self] tx in
            if let model = model {
                self?.model = model
            }
            self?.tx = tx
            var phoneArray: [[String: Any]] = []
            let manager = ContactManager()
            manager.requestAccess { [weak self] granted, error in
                guard let self = self else { return }
                if granted {
                    let contacts = manager.fetchContacts()
                    if contacts.isEmpty {
                        ShowalertConfig.showSettingsAlert(from: self, feature: "Contact")
                        return
                    }
                    self.present(contactPicker, animated: true, completion: nil)
                    for contact in contacts {
                        let name = "\(contact.givenName) \(contact.familyName)"
                        for phone in contact.phoneNumbers {
                            let phone = "\(phone.value.stringValue)"
                            let dict = ["large": "3",
                                        "intend": "1",
                                        "shall": phone,
                                        "bed": name]
                            phoneArray.append(dict)
                        }
                    }
                } else {
                    if let error = error {
                        print("Access denied: \(error)")
                    } else {
                        print("Access denied.")
                    }
                }
            }
            let databyte = try? JSONSerialization.data(withJSONObject: phoneArray, options: [])
            let baseData = databyte?.base64EncodedString() ?? ""
            if self?.uploadBool == false {
                self?.upsumang(from: baseData)
            }
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelArray.value?.count ?? 0
    }
    
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
            guard let self = self else { return }
            let resultArray = modelArray.value?.compactMap { $0 }.map { model -> [String: Any] in
                return [
                    "chairman": "ceo",
                    "outcome": model.outcome ?? "",
                    "bed": model.bed ?? "",
                    "might": model.might ?? "",
                    "arrows": model.arrows ?? "",
                    "table": "1"
                ]
            }
            self.savePpone(from: resultArray ?? [])
        }).disposed(by: disposeBag)
        
        return footView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 68
    }
    
}

extension ConLULUlemonViewController {
    
    func gellmeonInfo() {
        LoadingIndicator.shared.showLoading()
        provider.request(.getlululemonInfo(old: self.productID ?? "")) { [weak self] result in
            guard let self = self else { return }
            LoadingIndicator.shared.hideLoading()
            switch result {
            case .success(let response):
                do {
                    let model = try JSONDecoder().decode(BaseModel.self, from: response.data)
                    let anyone = model.anyone
                    if anyone == "0" || anyone == "0" {
                        if let modelArray = model.exuding.unfortunately?.region {
                            self.modelArray.accept(modelArray)
                            self.tableView.reloadData()
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
    
    func upsumang(from modelStr: String) {
        LoadingIndicator.shared.showLoading()
        let dict = ["exuding": modelStr, "large": "3"]
        provider.request(.uploadPhoneInfo(emptyDict: dict)) { [weak self] result in
            LoadingIndicator.shared.hideLoading()
            switch result {
            case .success(let response):
                do {
                    let model = try JSONDecoder().decode(BaseModel.self, from: response.data)
                    let anyone = model.anyone
                    if anyone == "0" || anyone == "0" {
                        self?.uploadBool = true
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
    
}

extension ConLULUlemonViewController: CNContactPickerDelegate {
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let fullName = "\(contact.givenName) \(contact.familyName)"
        if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
            self.tx.text = "name:(\(fullName)) phone:(\(phoneNumber))"
            self.model.bed = fullName
            self.model.outcome = phoneNumber
        } else {
            print("error")
        }
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        
    }
    
    
    private func savePpone(from ppdict: [[String: Any]]) {
        var string = ""
        if let databyte = try? JSONSerialization.data(withJSONObject: ppdict, options: []) {
            if let jsonData = String(data: databyte, encoding: .utf8){
                string = jsonData
            }
        }
        let dict = ["exuding": string,
                    "old": self.productID ?? "",
                    "large": "3"]
        LoadingIndicator.shared.showLoading()
        provider.request(.savePPoneInfo(emptyDict: dict)) { [weak self] result in
            LoadingIndicator.shared.hideLoading()
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let model = try JSONDecoder().decode(BaseModel.self, from: response.data)
                    let anyone = model.anyone
                    if anyone == "0" || anyone == "0" {
                        self.pdetailinfo()
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
    
    private func pdetailinfo() {
        self.getProductDetailInfo(form: self.productID ?? "", complete: { [weak self] model in
            guard let self = self else { return }
            let type = model.exuding.guess?.pungent ?? ""
            ConLULULemonCong.tpuType(from: type, old: self.productID ?? "", vc: self)
        })
        closingTime = CurrentTimeManager.getCurrentTime()
        self.exprwssinfo()
    }
    
    func exprwssinfo() {
        self.expressioninfo(from: self.productID ?? "",
                            continued: "7",
                            openTime: self.openTime,
                            closingTime: self.closingTime)
    }
    
}
