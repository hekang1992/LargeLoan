//
//  HomeViewController.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/14.
//

import UIKit
import RxRelay
import MJRefresh
import CoreLocation

class HomeViewController: BaseViewController {
    
    lazy var subView: HomeSubView = {
        let subView = HomeSubView()
        return subView
    }()
    
    var homeModel = BehaviorRelay<BaseModel?>(value: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.applyImageView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                let sparkle = self.homeModel.value?.exuding.sparkle ?? 0
                guard sparkle == 1 else {
                    self.apply()
                    return
                }
                let status: CLAuthorizationStatus
                if #available(iOS 14.0, *) {
                    status = CLLocationManager().authorizationStatus
                } else {
                    status = CLLocationManager.authorizationStatus()
                }
                switch status {
                case .restricted, .denied:
                    ShowalertConfig.showSettingsAlert(from: self, feature: "Location")
                default:
                    self.apply()
                }
            }).disposed(by: disposeBag)
        
        self.subView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            getHomedata()
        })
        
        
        let man = LocationManager()
        man.requestLoaction { model in
            print("modeltake=======\(model.take)")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getHomedata()
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

extension HomeViewController {
    
    private func getHomedata() {
        LoadingIndicator.shared.showLoading()
        provider.request(.toHomeData) { [weak self] result in
            LoadingIndicator.shared.hideLoading()
            guard let self = self else { return }
            self.subView.scrollView.mj_header?.endRefreshing()
            switch result {
            case .success(let response):
                do {
                    let model = try JSONDecoder().decode(BaseModel.self, from: response.data)
                    let anyone = model.anyone
                    if anyone == "0" || anyone == "0" {
                        self.homeModel.accept(model)
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
    
    private func apply() {
        let digging = self.homeModel.value?.exuding.palms?.something?.first?.digging ?? 0
        LoadingIndicator.shared.showLoading()
        provider.request(.applyInfo(productId: String(digging))) { [weak self] result in
//            LoadingIndicator.shared.hideLoading()
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let model = try JSONDecoder().decode(BaseModel.self, from: response.data)
                    let anyone = model.anyone
                    if anyone == "0" || anyone == "0" {
                        self.productInfo(form: model.exuding.raised ?? "")
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
    
    private func productInfo(form withUrl: String?) {
        if let url = withUrl, !url.isEmpty, url.hasPrefix(urlScheme), let sc = URL(string: url) {
            if let productId = jiequzifu(url: sc) {
                self.getProductDetailInfo(form: productId, complete: { [weak self] model in
                    let older = model.exuding.her?.older ?? ""
                    if let guess = model.exuding.guess, let pungent = guess.pungent, !pungent.isEmpty  {
                        let pushVc = ZTViewController()
                        pushVc.model = model
                        pushVc.proid = productId
                        self?.navigationController?.pushViewController(pushVc, animated: true)
                    }else {
                        self?.ddOrderinfo(from: older)
                    }
                })
            }
        }else {
            LoadingIndicator.shared.hideLoading()
            self.pushnetwork(from: withUrl ?? "")
        }
    }
    
}
