//
//  BaseViewController.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/12.
//

import UIKit
import RxSwift
import Moya

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let provider = MoyaProvider<LargeLoanAPI>()
    
    let StatusBarHeight = StatusBarConfig.getStatusBarHeight()
    
    let tabBarHeight = StatusBarConfig.tabBarHeight
    
    var openTime: String = ""
    var closingTime: String = ""
    
    var openNineTime: String = ""
    var closingNineTime: String = ""
    
    lazy var headView: HeadView = {
        let headView = HeadView()
        return headView
    }()
    
    lazy var homeImageView: UIImageView = {
        let homeImageView = UIImageView()
        homeImageView.image = UIImage(named: "homebg")
        homeImageView.isUserInteractionEnabled = true
        return homeImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
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


extension BaseViewController {
    
    func backInfo() {
        self.headView.backBtn.rx.tap.subscribe(onNext: { [weak self] in
            if let targetViewController = self?.navigationController?.viewControllers.first(where: { $0 is ZTViewController }) {
                self?.navigationController?.popToViewController(targetViewController, animated: true)
            }else {
                self?.navigationController?.popViewController(animated: true)
            }
        }).disposed(by: disposeBag)
    }
    
    func jiequzifu(url: URL) -> String? {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let queryItem = components.queryItems?.last,
              let value = queryItem.value else {
            return nil
        }
        return value
    }
    
    func getProductDetailInfo(form old: String, complete: @escaping ((BaseModel) -> Void)) {
        LoadingIndicator.shared.showLoading()
        provider.request(.productDetailInfo(productId: old)) { result in
            LoadingIndicator.shared.hideLoading()
            switch result {
            case .success(let response):
                do {
                    let model = try JSONDecoder().decode(BaseModel.self, from: response.data)
                    let anyone = model.anyone
                    if anyone == "0" {
                        complete(model)
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
    
    func allowEnter(from old: String, complete: @escaping ((BaseModel) -> Void)) {
        LoadingIndicator.shared.showLoading()
        provider.request(.southern(old: old)) { result in
            LoadingIndicator.shared.hideLoading()
            switch result {
            case .success(let response):
                do {
                    let model = try JSONDecoder().decode(BaseModel.self, from: response.data)
                    let anyone = model.anyone
                    if anyone == "0" {
                        complete(model)
                    }else {
                        ToastConfig.show(form: self.view, message: model.coldly)
                    }
                } catch {
                    print("JSON: \(error)")
                }
            case .failure(_):
                break
            }
        }
    }
    
}

extension BaseViewController {
    
    func ddOrderinfo(from olderId: String) {
        LoadingIndicator.shared.showLoading()
        let dict = ["fowls": "flowers",
                    "thought": olderId,
                    "soul": "love",
                    "dogs": "happy"]
        provider.request(.tonexturl(emptyDict: dict)) { [weak self] result in
            guard let self = self else { return }
            LoadingIndicator.shared.hideLoading()
            switch result {
            case .success(let response):
                do {
                    let model = try JSONDecoder().decode(BaseModel.self, from: response.data)
                    let anyone = model.anyone
                    if anyone == "0" {
                        if let url = model.exuding.raised {
                            pushnetwork(from: url)
                        }
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
    
    func pushnetwork(from url: String) {
        let wpVc = WebpageViewController()
        let pageUrl = DictToString.appendters(url: url, parameters: GetDengLuConfig.loginConfig()) ?? "".replacingOccurrences(of: " ", with: "%20")
        wpVc.webUrl.accept(pageUrl)
        self.navigationController?.pushViewController(wpVc, animated: true)
        print("pageUrl======\(pageUrl)")
    }
    
}


extension BaseViewController {
    
    func expressioninfo(from productID: String,
                        continued: String,
                        openTime: String,
                        closingTime: String) {
        let trman = LocationManager()
        trman.requestLoaction { [weak self] model in
            guard let self = self else { return }
            let dict = ["great": productID,
                        "continued": continued,
                        "anymore": GetIdfv.getIDFV(),
                        "wish": GetIdfa.getIDFA(),
                        "opportunity": model.opportunity,
                        "take": model.take,
                        "speaking": openTime,
                        "join": closingTime]
            provider.request(.expression(emptyDict: dict)) { result in
                switch result {
                case .success(_):
                    if continued == "1" {
                        UserDefaults.standard.setValue("1", forKey: "CONTINUEONE")
                        UserDefaults.standard.synchronize()
                    }
                    break
                case .failure(_):
                    break
                }
            }
        }
    }
    
    
}
