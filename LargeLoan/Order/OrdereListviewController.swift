//
//  OrdereListviewController.swift
//  LargeLoan
//
//  Created by 何康 on 2024/12/28.
//

import UIKit
import RxRelay
import MJRefresh

class OrdereListviewController: BaseViewController {
    
    var type: String = ""
    
    var name: String = ""
    
    private let emptyManager = AddEmptyManager()
    
    var modelArray = BehaviorRelay<[letModel]?>(value: nil)
    var letArray = BehaviorRelay<[letModel]?>(value: nil)
    
    lazy var bbView: UIView = {
        let bbView = UIView()
        bbView.backgroundColor = .clear
        return bbView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 44
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(OrderViewCell.self, forCellReuseIdentifier: "OrderViewCell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(homeImageView)
        homeImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        homeImageView.addSubview(self.headView)
        self.headView.namelabel.text = name
        self.headView.lemonView.backgroundColor = .clear
        headView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(StatusBarHeight + 50)
        }
        
        view.addSubview(bbView)
        bbView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview().offset(-2)
        }
        bbView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        getlIST(from: type)
        
        modelArray.asObservable().subscribe(onNext: { [weak self] modelayy in
            guard let self = self, let letAyy = modelayy  else { return }
            self.letArray.accept(letAyy)
        }).disposed(by: disposeBag)
        
        letArray.compactMap { $0 ?? [] }.asObservable().bind(to: tableView.rx.items(cellIdentifier: "OrderViewCell", cellType: OrderViewCell.self)) { index, model, cell in
            cell.model.accept(model)
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
        }.disposed(by: disposeBag)
        
        
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            getlIST(from: type)
        })
        
    }

}

extension OrdereListviewController {
    
    
    private func getlIST(from type: String) {
        LoadingIndicator.shared.showLoading()
        let dict = ["ago": "2",
                    "wolves": type,
                    "tears": "1"]
        provider.request(.getOListInfo(emptyDict: dict)) { [weak self] result in
            LoadingIndicator.shared.hideLoading()
            guard let self = self else { return }
            self.tableView.mj_header?.endRefreshing()
            switch result {
            case .success(let response):
                do {
                    let model = try JSONDecoder().decode(BaseModel.self, from: response.data)
                    let anyone = model.anyone
                    if anyone == "0" || anyone == "0" {
                        let regionArray = model.exuding.region ?? []
                        self.modelArray.accept(regionArray)
                        if !regionArray.isEmpty {
                            emptyManager.hideEmptyView()
                        }else {
                            emptyManager.showEmptyView(on: self.bbView)
                        }
                    }else {
                        ToastConfig.show(form: self.view, message: model.coldly)
                        emptyManager.showEmptyView(on: self.bbView)
                    }
                } catch {
                    print("JSON: \(error)")
                    emptyManager.showEmptyView(on: self.bbView)
                }
                break
            case .failure(_):
                emptyManager.showEmptyView(on: self.bbView)
                break
            }
        }
    }
    
    
}
