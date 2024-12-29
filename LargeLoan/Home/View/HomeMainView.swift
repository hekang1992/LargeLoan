//
//  MainView.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/15.
//

import UIKit
import RxRelay

class HomeMainView: BaseView {
    
    lazy var mainView: UIView = {
        let mainView = UIView()
        mainView.backgroundColor = .random()
        return mainView
    }()
    
    lazy var subView: UIView = {
        let subView = UIView()
        return subView
    }()
    
    lazy var tiIcon: UIImageView = {
        let tiIcon = UIImageView()
        tiIcon.image = UIImage(named: "tixinimage")
        return tiIcon
    }()
    
    lazy var liIcon: UIImageView = {
        let liIcon = UIImageView()
        liIcon.image = UIImage(named: "littllabaimage")
        return liIcon
    }()
    
    
    var model = BehaviorRelay<BaseModel?>(value: nil)
    var headmodel = BehaviorRelay<BaseModel?>(value: nil)
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 40
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ProductViewCell.self, forCellReuseIdentifier: "ProductViewCell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        model.compactMap{ $0?.exuding.skin?.something ?? [] }.asObservable().bind(to: tableView.rx.items(cellIdentifier: "ProductViewCell", cellType: ProductViewCell.self)) { row, model, cell in
            cell.model.accept(model)
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
        }.disposed(by: disposeBag)
        
        model.asObservable().subscribe(onNext: { [weak self] model in
            guard let model = model else { return }
            self?.headmodel.accept(model)
        }).disposed(by: disposeBag)
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension HomeMainView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let model = self.headmodel.value?.exuding.knelt
        if model?.something?.count ?? 0 > 0 {
            return 255
        }else {
            return 190
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView()
        headView.backgroundColor = .random()
        let model = self.headmodel.value?.exuding.knelt
        headView.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(StatusBarHeight + 10)
            make.left.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(120)
        }
        if model?.something?.count ?? 0 > 0 {
            subView.isHidden = false
            headView.addSubview(subView)
            subView.addSubview(tiIcon)
            subView.addSubview(liIcon)
            subView.snp.makeConstraints { make in
                make.top.equalTo(mainView.snp.bottom).offset(10)
                make.left.equalToSuperview().offset(16)
                make.centerX.equalToSuperview()
                make.height.equalTo(54)
            }
            tiIcon.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            liIcon.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset(14)
                make.size.equalTo(CGSize(width: 22, height: 26))
            }
        }else {
            subView.isHidden = true
        }
        return headView
    }
    
    
}
