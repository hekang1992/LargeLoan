//
//  FaceViewController.swift
//  LargeLoan
//
//  Created by 何康 on 2024/12/22.
//

import UIKit
import BRPickerView
import RxRelay

class FaceViewController: BaseViewController {
    
    var dataModel = BehaviorRelay<BaseModel?>(value: nil)
    
    var productID: String? {
        didSet {
            guard let productID = productID else { return }
            print("photo====productID======\(productID)")
        }
    }
    
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
        mlabel.text = "To ensere that loan is operated br you,the plaform needs to cerify your identity"
        mlabel.textColor = UIColor.init(cssStr: "#2B170A")
        mlabel.textAlignment = .center
        mlabel.numberOfLines = 0
        mlabel.font = .mediumFontOfSize(size: 18)
        return mlabel
    }()
    
    lazy var photoImageView: UIImageView = {
        let photoImageView = UIImageView()
        photoImageView.image = UIImage(named: "faceuploimfe")
        photoImageView.isUserInteractionEnabled = true
        return photoImageView
    }()
    
    lazy var tupelabel: UILabel = {
        let tupelabel = UILabel()
        tupelabel.textColor = UIColor.init(cssStr: "#2B170A")
        tupelabel.textAlignment = .left
        tupelabel.font = .mediumFontOfSize(size: 16)
        tupelabel.text = "Face"
        return tupelabel
    }()
    
    lazy var clickImageView: UIImageView = {
        let clickImageView = UIImageView()
        clickImageView.image = UIImage(named: "facelock9i")
        clickImageView.isUserInteractionEnabled = true
        return clickImageView
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.setImage(UIImage(named: "nextxiayibimage"), for: .normal)
        return nextBtn
    }()
    
    lazy var imagePicker: UIImagePickerController = {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.cameraDevice = .front
        return imagePicker
    }()
    
    var selectImage: UIImage? = nil
    
    var rise: String? = nil
    
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
        
        
        scrollView.addSubview(mlabel)
        
        mlabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(photoImageView)
        photoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mlabel.snp.bottom).offset(20)
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
        
        scrollView.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(123)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 345, height: 52))
            make.bottom.equalToSuperview().offset(-40)
        }
        
        phpClick()
        
        dataModel.asObservable().subscribe(onNext: { [weak self] model in
            guard let self = self, let model = model else { return }
            self.clickImageView.isUserInteractionEnabled = false
            self.rise = model.exuding.raised ?? ""
            self.clickImageView.kf.setImage(with: URL(string: model.exuding.raised ?? "")) { result in
                switch result {
                case .success(let value):
                    print("Image successfully loaded: \(value.image)")
                    self.selectImage = value.image
                case .failure(let error):
                    print("Error loading image: \(error.localizedDescription)")
                }
            }
        }).disposed(by: disposeBag)
        
    }
    
}

extension FaceViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    private func phpClick() {
        clickImageView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.clickCamera()
            }).disposed(by: disposeBag)
        
        
        nextBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            if self.rise == nil {
                self.clickCamera()
            }else {
                self.toProductDetailInfo()
            }
        }).disposed(by: disposeBag)
        
    }
    
    private func clickCamera() {
        PermissionManager.checkCameraPermission(from: self) { [weak self] granted in
            if granted {
                if let self = self {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        self.ycCamerinfo(in: self.imagePicker.view)
                    }
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
        let dict = ["failure": "2",
                    "old": productID ?? "",
                    "1large": "11",
                    "large": "10",
                    "l2arge": "12",
                    "defeated": "",
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
                        self.clickImageView.isUserInteractionEnabled = false
                        self.clickImageView.image = self.selectImage
                        self.rise = "1"
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
    
    private func ycCamerinfo(in view: UIView) {
        for subview in view.subviews {
            if let button = subview as? UIButton, button.description.contains("CAMFlipButton") {
                button.isHidden = true
            } else {
                ycCamerinfo(in: subview)
            }
        }
    }
    
    private func toProductDetailInfo() {
        self.getProductDetailInfo(form: self.productID ?? "") { [weak self] model in
            let type = model.exuding.guess?.pungent ?? ""
            if type == "solargeg" {
                let oneVc = AuthYIViewController()
                oneVc.productID = self?.productID
                self?.navigationController?.pushViewController(oneVc, animated: true)
            }
        }
    }
    
}