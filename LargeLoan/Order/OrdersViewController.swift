//
//  OrdersViewController.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/14.
//

import UIKit
import MJRefresh

class OrdersViewController: BaseViewController {
    
    private let emptyManager = AddEmptyManager()
    
    lazy var orView: OrderView = {
        let orView = OrderView()
        return orView
    }()
    
    var tupe: String = "7"

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(orView)
        orView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        orView.oneBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.getlIST(from: "7")
            self.tupe = "7"
            orView.oneBtn.alpha = 1.0
            orView.twoBtn.alpha = 0.6
            orView.threeBtn.alpha = 0.6
        }).disposed(by: disposeBag)
        
        orView.twoBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.getlIST(from: "6")
            self.tupe = "6"
            orView.oneBtn.alpha = 0.6
            orView.twoBtn.alpha = 1.0
            orView.threeBtn.alpha = 0.6
        }).disposed(by: disposeBag)
        
        orView.threeBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.getlIST(from: "5")
            self.tupe = "5"
            orView.oneBtn.alpha = 0.6
            orView.twoBtn.alpha = 0.6
            orView.threeBtn.alpha = 1.0
        }).disposed(by: disposeBag)
        
        self.orView.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            getlIST(from: tupe)
        })
        
        self.orView.tableView.rx.modelSelected(letModel.self).subscribe(onNext: { [weak self] model in
            if let url = model.countries, !url.isEmpty, url.hasPrefix(urlScheme), let sc = URL(string: url) {
                if let productId = self?.jiequzifu(url: sc) {
                    self?.getProductDetailInfo(form: productId, complete: { [weak self] model in
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
                self?.pushnetwork(from: model.countries ?? "")
            }
        }).disposed(by: disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getlIST(from: self.tupe)
    }

}

extension OrdersViewController {
    
    private func getlIST(from type: String) {
        LoadingIndicator.shared.showLoading()
        let dict = ["ago": "2",
                    "wolves": type,
                    "tears": "1"]
        provider.request(.getOListInfo(emptyDict: dict)) { [weak self] result in
            LoadingIndicator.shared.hideLoading()
            self?.orView.tableView.mj_header?.endRefreshing()
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let model = try JSONDecoder().decode(BaseModel.self, from: response.data)
                    let anyone = model.anyone
                    if anyone == "0" {
                        let regionArray = model.exuding.region ?? []
                        self.orView.modelArray.accept(regionArray)
                        if !regionArray.isEmpty {
                            emptyManager.hideEmptyView()
                        }else {
                            emptyManager.showEmptyView(on: self.orView.whiteView)
                        }
                    }else {
                        ToastConfig.show(form: self.view, message: model.coldly)
                        emptyManager.showEmptyView(on: self.orView.whiteView)
                    }
                } catch {
                    print("JSON: \(error)")
                    emptyManager.showEmptyView(on: self.orView.whiteView)
                }
                break
            case .failure(_):
                emptyManager.showEmptyView(on: self.orView.whiteView)
                break
            }
        }
    }
    
    
}
