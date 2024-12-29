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
    
    lazy var mainView: HomeMainView = {
        let mainView = HomeMainView()
        return mainView
    }()
    
    var homeModel = BehaviorRelay<BaseModel?>(value: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        subView.applyImageView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                let sparkle = self.homeModel.value?.exuding.sparkle ?? 0
                guard sparkle == 1 else {
                    self.apply(from: self.homeModel.value?.exuding.palms?.something?.first?.digging ?? 0)
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
                    self.apply(from: self.homeModel.value?.exuding.palms?.something?.first?.digging ?? 0)
                    //deviceinfo loaction
                }
            }).disposed(by: disposeBag)
        
        self.mainView.tableView.rx.modelSelected(somethingModel.self).subscribe(onNext: { [weak self] model in
            guard let self = self else { return }
            self.apply(from: model.digging ?? 0)
        }).disposed(by: disposeBag)
        
        self.subView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            getHomedata()
        })
        
        let loaman = LocationManager()
        loaman.requestLoaction { [weak self] model in
            guard let self = self else { return }
            let dict = ["hide": model.hide,
                        "thousand": model.thousand,
                        "five": model.five,
                        "revenge": model.revenge,
                        "take": model.take,
                        "opportunity": model.opportunity,
                        "training": model.training,
                        "horses": "beef",
                        "selling": "smile"]
            provider.request(.thinkInfo(emptyDict: dict)) { result in
                
            }
        }
        
        let sbman = LocationManager()
        sbman.requestLoaction { [weak self] model in
            guard let self = self else { return }
            let dict = GetDAllInfo.getAllInfo()
            let databyte = try? JSONSerialization.data(withJSONObject: dict)
            let baseStr = databyte?.base64EncodedString() ?? ""
            provider.request(.scsecurtymessage(exuding: baseStr)) { result in
                
            }
        }
        
        let oneTime = UserDefaults.standard.object(forKey: OPEN_TIME) as? String ?? ""
        let twoTime = UserDefaults.standard.object(forKey: CLOSE_TIME) as? String ?? ""
        let digging = String(self.homeModel.value?.exuding.palms?.something?.first?.digging ?? 0)
        self.expressioninfo(from: digging, continued: "1", openTime: oneTime, closingTime: twoTime)
        
        
        homeModel.asObservable()
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] model in
                guard let self = self else { return }
                let hasSkinData = !(model.exuding.skin?.something?.isEmpty ?? true)
                self.updateViewVisibility(hasSkinData: hasSkinData)
            })
            .disposed(by: disposeBag)
        
        view.addSubview(subView)
        view.addSubview(mainView)
        subView.isHidden = true
        mainView.isHidden = true
        [subView, mainView].forEach { view in
            view.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
        self.mainView.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            getHomedata()
        })
        
        self.mainView.bblock = { [weak self] str in
            self?.pushnetwork(from: str)
        }
        self.mainView.bllock = { [weak self] str in
            self?.pushnetwork(from: str)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getHomedata()
    }
    
    private func updateViewVisibility(hasSkinData: Bool) {
        subView.isHidden = hasSkinData
        mainView.isHidden = !hasSkinData
        if mainView.isHidden == false {
            self.mainView.importView.reloadData()
            self.mainView.notimpView.reloadData()
        }
    }
    
}

extension HomeViewController {
    
    private func getHomedata() {
        LoadingIndicator.shared.showLoading()
        provider.request(.toHomeData) { [weak self] result in
            LoadingIndicator.shared.hideLoading()
            guard let self = self else { return }
            self.subView.scrollView.mj_header?.endRefreshing()
            self.mainView.tableView.mj_header?.endRefreshing()
            switch result {
            case .success(let response):
                do {
                    let model = try JSONDecoder().decode(BaseModel.self, from: response.data)
                    let anyone = model.anyone
                    if anyone == "0" || anyone == "0" {
                        self.homeModel.accept(model)
                        self.mainView.model.accept(model)
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
    
    private func apply(from digging: Int) {
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
