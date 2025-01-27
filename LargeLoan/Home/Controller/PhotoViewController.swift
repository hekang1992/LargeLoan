//
//  PhotoViewController.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/20.
//

import UIKit
import BRPickerView
import RxRelay

class PView: BaseView {
    
    lazy var pereImageView: UIImageView = {
        let pereImageView = UIImageView()
        pereImageView.isUserInteractionEnabled = true
        pereImageView.image = UIImage(named: "popselecimge")
        return pereImageView
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
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        return cancelBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(pereImageView)
        pereImageView.addSubview(oneBtn)
        pereImageView.addSubview(twoBtn)
        pereImageView.addSubview(threeBtn)
        pereImageView.addSubview(cancelBtn)
        pereImageView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(280)
        }
        cancelBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.right.equalToSuperview().offset(-6)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        oneBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.left.right.equalToSuperview()
            make.height.equalTo(46)
        }
        twoBtn.snp.makeConstraints { make in
            make.top.equalTo(oneBtn.snp.bottom).offset(25)
            make.left.right.equalToSuperview()
            make.height.equalTo(46)
        }
        threeBtn.snp.makeConstraints { make in
            make.top.equalTo(twoBtn.snp.bottom).offset(15)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class PhotoViewController: BaseViewController {
    
    var type: String? {
        didSet {
            guard let type = type else { return }
            print("type========\(type)")
        }
    }
    
    var productID: String? {
        didSet {
            guard let productID = productID else { return }
        }
    }
    
    var dataModel = BehaviorRelay<BaseModel?>(value: nil)
    
    lazy var aupView: PView = {
        let aupView = PView(frame: self.view.bounds)
        return aupView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    lazy var bigManLabel: UILabel = {
        let bigManLabel = UILabel()
        bigManLabel.text = "Verify Identity"
        bigManLabel.textColor = UIColor.init(colorHexStr: "#2B170A")
        bigManLabel.textAlignment = .center
        bigManLabel.font = .mediumFontOfSize(size: 18)
        return bigManLabel
    }()
    
    lazy var minSoulLabel: UILabel = {
        let minSoulLabel = UILabel()
        let typeStr = "Authenticate your identity"
        let issueStr = "and personal details."
        minSoulLabel.text = typeStr + " " + issueStr
        minSoulLabel.textColor = UIColor.init(colorHexStr: "#2B170A")
        minSoulLabel.textAlignment = .center
        minSoulLabel.font = .mediumFontOfSize(size: 13)
        return minSoulLabel
    }()
    
    lazy var photoImageView: UIImageView = {
        let photoImageView = UIImageView()
        photoImageView.image = UIImage(named: "phontimage")
        photoImageView.isUserInteractionEnabled = true
        return photoImageView
    }()
    
    lazy var tupelabel: UILabel = {
        let tupelabel = UILabel()
        tupelabel.textColor = UIColor.init(colorHexStr: "#2B170A")
        tupelabel.textAlignment = .left
        tupelabel.font = .mediumFontOfSize(size: 16)
        tupelabel.text = type ?? ""
        return tupelabel
    }()
    
    lazy var clickImageView: UIImageView = {
        let clickImageView = UIImageView()
        clickImageView.image = UIImage(named: "caputifimage")
        clickImageView.isUserInteractionEnabled = true
        return clickImageView
    }()
    
    lazy var layerView: UIView = {
        let layerView = UIView()
        layerView.layer.cornerRadius = 12
        layerView.backgroundColor = .init(colorHexStr: "#FFFAF1")
        return layerView
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.setImage(UIImage(named: "nextxiayibimage"), for: .normal)
        return nextBtn
    }()
    
    lazy var corView: UIView = {
        let corView = UIView()
        corView.backgroundColor = .white
        return corView
    }()
    
    lazy var ttlabel: UILabel = {
        let ttlabel = UILabel()
        let oneStr = "Kindly verify your personal"
        let twoStr = "identification details."
        ttlabel.text = oneStr + " " + twoStr
        ttlabel.textColor = UIColor.init(colorHexStr: "#2B170A")
        ttlabel.textAlignment = .center
        ttlabel.font = .mediumFontOfSize(size: 16)
        return ttlabel
    }()
    
    lazy var oneView: EnterTextView = {
        let oneView = EnterTextView()
        oneView.bigManLabel.text = "Name"
        oneView.lemonView.isUserInteractionEnabled = false
        return oneView
    }()
    
    lazy var twoView: EnterTextView = {
        let twoView = EnterTextView()
        twoView.bigManLabel.text = "ID No."
        twoView.lemonView.isUserInteractionEnabled = false
        return twoView
    }()
    
    lazy var threeView: EnterBtnView = {
        let threeView = EnterBtnView()
        threeView.bigManLabel.text = "Date"
        threeView.lemonView.isUserInteractionEnabled = false
        return threeView
    }()
    
    lazy var descView: PopAuthDescView = {
        let descView = PopAuthDescView(frame: self.view.bounds)
        return descView
    }()
    
    var selectImage: UIImage? = nil
    
    var name: String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(homeImageView)
        homeImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backInfo()
        view.addSubview(self.headView)
        self.headView.lemonView.backgroundColor = .clear
        self.headView.namelabel.text = "Identity Information"
        headView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(StatusBarHeight + 50)
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(headView.snp.bottom).offset(10)
        }
        
        scrollView.addSubview(corView)
        corView.snp.makeConstraints { make in
            make.width.equalTo(SCREEN_WIDTH)
            make.left.bottom.top.equalToSuperview()
        }
        
        scrollView.addSubview(bigManLabel)
        scrollView.addSubview(minSoulLabel)
        
        bigManLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(22)
        }
        minSoulLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bigManLabel.snp.bottom).offset(10)
            make.height.equalTo(16)
        }
        
        scrollView.addSubview(photoImageView)
        photoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(minSoulLabel.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 355, height: 411))
        }
        
        photoImageView.addSubview(tupelabel)
        tupelabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(22)
        }
        
        photoImageView.addSubview(clickImageView)
        clickImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 315, height: 177))
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(60)
        }
        
        scrollView.addSubview(layerView)
        layerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(photoImageView.snp.bottom).offset(17)
            make.size.equalTo(CGSize(width: 343, height: 365))
        }
        
        scrollView.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.top.equalTo(layerView.snp.bottom).offset(18)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 345, height: 52))
            make.bottom.equalToSuperview().offset(-40)
        }
        
        layerView.addSubview(ttlabel)
        ttlabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(22)
        }
        
        layerView.addSubview(oneView)
        layerView.addSubview(twoView)
        layerView.addSubview(threeView)
        
        corView.layoutIfNeeded()
        corView.setTopCorners(radius: 20)
        
        oneView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(52)
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(83)
        }
        
        twoView.snp.makeConstraints { make in
            make.top.equalTo(oneView.snp.bottom).offset(15)
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(83)
        }
        
        threeView.snp.makeConstraints { make in
            make.top.equalTo(twoView.snp.bottom).offset(15)
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(83)
        }
        phpClick()
        
        dataModel.asObservable().subscribe(onNext: { [weak self] model in
            guard let self = self, let model = model, let imageUrl = model.exuding.smiled?.raised, !imageUrl.isEmpty else { return }
            self.clickImageView.isUserInteractionEnabled = false
            self.clickImageView.kf.setImage(with: URL(string: model.exuding.smiled?.raised ?? ""), placeholder: UIImage(named: "caputifimage")) { result in
                switch result {
                case .success(let value):
                    print("Image successfully loaded: \(value.image)")
                    self.selectImage = value.image
                case .failure(let error):
                    print("Error loading image: \(error.localizedDescription)")
                }
            }
            self.oneView.enterTx.text = model.exuding.smiled?.determination?.oneName ?? ""
            self.twoView.enterTx.text = model.exuding.smiled?.determination?.twoNumbe ?? ""
            self.threeView.enterTx.text = model.exuding.smiled?.determination?.threeDate ?? ""
            self.name = self.oneView.enterTx.text ?? ""
        }).disposed(by: disposeBag)
        
    }
    
}

extension PhotoViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        allowEnter(from: productID ?? "", complete: { model in
            self.dataModel.accept(model)
        })
    }
    
    private func phpClick() {
        clickImageView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.clickPhoto()
        }).disposed(by: disposeBag)
        
        nextTapClick()
    }
    
    private func clickPhoto() {
        openTime = CurrentTimeManager.getCurrentTime()
        ShowalertConfig.alertShow(form: self.aupView, vc: self, style: .actionSheet)
        
        self.aupView.cancelBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.dismiss(animated: true)
        }).disposed(by: disposeBag)
        
        self.aupView.threeBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.dismiss(animated: true)
        }).disposed(by: disposeBag)
        
        self.aupView.oneBtn.rx.tap.subscribe(onNext: { [weak self] in
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            guard let self = self else { return }
            self.dismiss(animated: true, completion: {
                PermissionManager.checkCameraPermission(from: self) { [weak self] granted in
                    if granted {
                        if let self = self {
                            self.present(imagePicker, animated: true)
                        }
                    }
                }
            })
        }).disposed(by: disposeBag)
        
        self.aupView.twoBtn.rx.tap.subscribe(onNext: { [weak self] in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            guard let self = self else { return }
            self.dismiss(animated: true, completion: {
                PermissionManager.checkPhotoLibraryPermission(from: self) { [weak self] granted in
                    if granted {
                        if let self = self {
                            self.present(imagePicker, animated: true)
                        }
                    }
                }
            })
        }).disposed(by: disposeBag)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage, let data = Data.compressImageTo1MB(image: image) {
            self.selectImage = image
            picker.dismiss(animated: true) { [weak self] in
                self?.uploadImage(with: data)
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func uploadImage(with model: Data) {
        LoadingIndicator.shared.showLoading()
        let dict = ["failure": "1",
                    "old": productID ?? "",
                    "large": "11",
                    "defeated": type ?? "",
                    "heal": "",
                    "stops": "image",
                    "easy": "1"] as [String: String]
        provider.request(.uploadPhotoImage(dict: dict, difficult: model)) { [weak self] result in
            guard let self = self else { return }
            LoadingIndicator.shared.hideLoading()
            switch result {
            case .success(let response):
                do {
                    let model = try JSONDecoder().decode(BaseModel.self, from: response.data)
                    let anyone = model.anyone
                    if anyone == "0" {
                        self.saveModel(with: model)
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
    
    func saveModel(with model: BaseModel) {
        self.closingTime = CurrentTimeManager.getCurrentTime()
        descView.oneView.enterTx.text = model.exuding.bed ?? ""
        descView.twoView.enterTx.text = model.exuding.willpower ?? ""
        descView.threeView.enterTx.text = model.exuding.strong ?? ""
        ShowalertConfig.alertShow(form: descView, vc: self, style: .actionSheet)
        descView.backBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.dismiss(animated: true)
        }).disposed(by: disposeBag)
        descView.sageBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.bcNameInfo(model)
        }).disposed(by: disposeBag)
        
        descView.threeView.clickBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.timeInfo(tx: self?.descView.threeView.enterTx ?? UITextField())
        }).disposed(by: disposeBag)
    }
    
    private func timeInfo(tx: UITextField) {
        self.setUpTime(form: tx)
    }
    
    private func bcNameInfo(_ model: BaseModel) {
        LoadingIndicator.shared.showLoading()
        let one = descView.oneView.enterTx.text ?? ""
        let two = descView.twoView.enterTx.text ?? ""
        let three = descView.threeView.enterTx.text ?? ""
        provider.request(.saveNameInfo(old: productID ?? "", name: one, num: two, date: three, defeated: type ?? "")) { [weak self] result in
            guard let self = self else { return }
            LoadingIndicator.shared.hideLoading()
            switch result {
            case .success(let response):
                do {
                    let model = try JSONDecoder().decode(BaseModel.self, from: response.data)
                    let anyone = model.anyone
                    if anyone == "0" {
                        self.oneView.enterTx.text = one
                        self.twoView.enterTx.text = two
                        self.threeView.enterTx.text = three
                        self.name = one
                        self.clickImageView.image = self.selectImage
                        self.clickImageView.isUserInteractionEnabled = false
                        self.dismiss(animated: true) {
                            self.exprwssinfo()
                        }
                        self.goneFucVino()
                    }
                    ToastConfig.show(form: descView, message: model.coldly)
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


extension PhotoViewController {
    
    private func setUpTime(form tx: UITextField) {
        guard let dateComponents = extractDateComponents(from: tx.text) else { return }
        let datePickerView = createDatePickerView(with: dateComponents)
        datePickerView.resultBlock = { selectDate, selectValue in
            guard let selectValue = selectValue else { return }
            let selectedArray = selectValue.components(separatedBy: "-")
            if selectedArray.count == 3 {
                let selectedDay = selectedArray[2]
                let selectedMonth = selectedArray[1]
                let selectedYear = selectedArray[0]
                let timeStr = String(format: "%@-%@-%@", selectedDay, selectedMonth, selectedYear)
                tx.text = timeStr
            }
        }
        let customStyle = ColorEnemConfig.configureStyle()
        datePickerView.pickerStyle = customStyle
        datePickerView.show()
    }

    private func extractDateComponents(from text: String?) -> (day: Int, month: Int, year: Int)? {
        let defaultDate = "11-11-1911"
        let timeStr = text ?? defaultDate
        let timeArray = timeStr.components(separatedBy: "-")
        guard timeArray.count == 3,
              let day = Int(timeArray[0]),
              let month = Int(timeArray[1]),
              let year = Int(timeArray[2]) else {
            return nil
        }
        return (day, month, year)
    }

    private func createDatePickerView(with dateComponents: (day: Int, month: Int, year: Int)) -> BRDatePickerView {
        let datePickerView = BRDatePickerView()
        datePickerView.pickerMode = .YMD
        datePickerView.title = "Date"
        datePickerView.minDate = NSDate.br_setYear(1911, month: 11, day: 11)
        datePickerView.selectDate = NSDate.br_setYear(dateComponents.year, month: dateComponents.month, day: dateComponents.day)
        datePickerView.maxDate = Date()
        return datePickerView
    }
}

extension PhotoViewController {
    
    private func nextTapClick() {
        nextBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.goneFucVino()
        }).disposed(by: disposeBag)
    }
    
    private func goneFucVino() {
        if self.name == nil {
            self.clickPhoto()
        }else {
            let faceVc = FaceViewController()
            faceVc.productID = self.productID
            if let model = self.dataModel.value {
                faceVc.dataModel.accept(model)
            }
            self.navigationController?.pushViewController(faceVc, animated: true)
        }
    }
}

extension PhotoViewController {
    
    func exprwssinfo() {
        self.expressioninfo(from: self.productID ?? "",
                            continued: "3",
                            openTime: self.openTime,
                            closingTime: self.closingTime)
    }
    
}
