//
//  PhotoViewController.swift
//  LargeLoan
//
//  Created by 何康 on 2024/12/20.
//

import UIKit
import BRPickerView
import RxRelay

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
            print("photo====productID======\(productID)")
        }
    }
    
    var dataModel = BehaviorRelay<BaseModel?>(value: nil)
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    lazy var mlabel: UILabel = {
        let mlabel = UILabel()
        mlabel.text = "Verify Identity"
        mlabel.textColor = UIColor.init(cssStr: "#2B170A")
        mlabel.textAlignment = .center
        mlabel.font = .mediumFontOfSize(size: 18)
        return mlabel
    }()
    
    lazy var desclabel: UILabel = {
        let desclabel = UILabel()
        desclabel.text = "Verify Identity and name information"
        desclabel.textColor = UIColor.init(cssStr: "#2B170A")
        desclabel.textAlignment = .center
        desclabel.font = .mediumFontOfSize(size: 13)
        return desclabel
    }()
    
    lazy var photoImageView: UIImageView = {
        let photoImageView = UIImageView()
        photoImageView.image = UIImage(named: "phontimage")
        photoImageView.isUserInteractionEnabled = true
        return photoImageView
    }()
    
    lazy var tupelabel: UILabel = {
        let tupelabel = UILabel()
        tupelabel.textColor = UIColor.init(cssStr: "#2B170A")
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
        layerView.backgroundColor = .init(cssStr: "#FFFAF1")
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
        ttlabel.text = "Please confirm your identity information"
        ttlabel.textColor = UIColor.init(cssStr: "#2B170A")
        ttlabel.textAlignment = .center
        ttlabel.font = .mediumFontOfSize(size: 16)
        return ttlabel
    }()
    
    lazy var oneView: EnterTextView = {
        let oneView = EnterTextView()
        oneView.mlabel.text = "Full Name"
        oneView.bgView.isUserInteractionEnabled = false
        return oneView
    }()
    
    lazy var twoView: EnterTextView = {
        let twoView = EnterTextView()
        twoView.mlabel.text = "ID No."
        twoView.bgView.isUserInteractionEnabled = false
        return twoView
    }()
    
    lazy var threeView: EnterBtnView = {
        let threeView = EnterBtnView()
        threeView.mlabel.text = "Date of Birth"
        threeView.bgView.isUserInteractionEnabled = false
        return threeView
    }()
    
    lazy var imagePicker: UIImagePickerController = {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        return imagePicker
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
        
        view.addSubview(self.headView)
        self.headView.bgView.backgroundColor = .clear
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
        
        scrollView.addSubview(mlabel)
        scrollView.addSubview(desclabel)
        
        mlabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(22)
        }
        desclabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mlabel.snp.bottom).offset(10)
            make.height.equalTo(16)
        }
        
        scrollView.addSubview(photoImageView)
        photoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(desclabel.snp.bottom).offset(20)
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
            make.size.equalTo(CGSize(width: 343, height: 325))
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
            make.height.equalTo(73)
        }
        
        twoView.snp.makeConstraints { make in
            make.top.equalTo(oneView.snp.bottom).offset(20)
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(73)
        }
        
        threeView.snp.makeConstraints { make in
            make.top.equalTo(twoView.snp.bottom).offset(20)
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(73)
        }
        phpClick()
        
        dataModel.asObservable().subscribe(onNext: { [weak self] model in
            guard let self = self, let model = model else { return }
            self.clickImageView.isUserInteractionEnabled = false
            self.clickImageView.kf.setImage(with: URL(string: model.exuding.smiled?.raised ?? "")) { result in
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
        
        
        nextBtn.rx.tap.subscribe(onNext: { [weak self] in
            if self?.name == nil {
                self?.clickPhoto()
            }else {
                let faceVc = FaceViewController()
                faceVc.productID = self?.productID
                if let model = self?.dataModel.value {
                    faceVc.dataModel.accept(model)
                }
                self?.navigationController?.pushViewController(faceVc, animated: true)
            }
        }).disposed(by: disposeBag)
        
    }
    
    private func clickPhoto() {
        PermissionManager.checkPhotoLibraryPermission(from: self) { [weak self] granted in
            if granted {
                if let self = self {
                    self.present(self.imagePicker, animated: true)
                }
            }else {
                
            }
        }
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
                    if anyone == "0" || anyone == "0" {
                        self.saveModel(with: model)
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
                    if anyone == "0" || anyone == "0" {
                        self.oneView.enterTx.text = one
                        self.twoView.enterTx.text = two
                        self.threeView.enterTx.text = three
                        self.name = one
                        self.clickImageView.image = self.selectImage
                        self.clickImageView.isUserInteractionEnabled = false
                        self.dismiss(animated: true)
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
        let customStyle = configureDatePickerStyle()
        datePickerView.pickerStyle = customStyle
        datePickerView.show()
    }

    private func extractDateComponents(from text: String?) -> (day: Int, month: Int, year: Int)? {
        let defaultDate = "01-10-1949"
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
        datePickerView.minDate = NSDate.br_setYear(1949, month: 10, day: 01)
        datePickerView.selectDate = NSDate.br_setYear(dateComponents.year, month: dateComponents.month, day: dateComponents.day)
        datePickerView.maxDate = Date()
        return datePickerView
    }

    private func configureDatePickerStyle() -> BRPickerStyle {
        let customStyle = BRPickerStyle()
        customStyle.pickerColor = .white
        customStyle.pickerTextFont = .mediumFontOfSize(size: 16)
        customStyle.selectRowTextColor = .black
        return customStyle
    }
}
