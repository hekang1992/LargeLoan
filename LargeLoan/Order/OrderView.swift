//
//  OrderView.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/15.
//

import UIKit
import RxRelay

class OrderView: BaseView {
    
    var cellBlock: ((letModel) -> Void)?
    
    var modelArray = BehaviorRelay<[letModel]?>(value: nil)

    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "centerbg")
        return bgImageView
    }()
    
    lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        return whiteView
    }()
    
    lazy var lemonView: UIView = {
        let lemonView = UIView()
        lemonView.layer.cornerRadius = 16
        lemonView.backgroundColor = UIColor.init(colorHexStr: "#FF7F38")
        return lemonView
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        oneBtn.alpha = 1.0
        oneBtn.titleLabel?.font = .mediumFontOfSize(size: 12)
        oneBtn.setTitle("Apply", for: .normal)
        oneBtn.setImage(UIImage(named: "applyiocn"), for: .normal)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        twoBtn.titleLabel?.font = .mediumFontOfSize(size: 12)
        twoBtn.setTitle("Repayment", for: .normal)
        twoBtn.setImage(UIImage(named: "Repaymentimge"), for: .normal)
        twoBtn.alpha = 0.6
        return twoBtn
    }()
    
    lazy var threeBtn: UIButton = {
        let threeBtn = UIButton(type: .custom)
        threeBtn.alpha = 0.6
        threeBtn.titleLabel?.font = .mediumFontOfSize(size: 12)
        threeBtn.setTitle("Finished", for: .normal)
        threeBtn.setImage(UIImage(named: "Finishedimge"), for: .normal)
        return threeBtn
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 44
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(OrderViewCell.self, forCellReuseIdentifier: "OrderViewCell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        self.headView.backBtn.isHidden = true
        self.headView.lemonView.backgroundColor = .clear
        self.headView.namelabel.text = "Order"
        bgImageView.addSubview(self.headView)
        
        addSubview(whiteView)
        addSubview(lemonView)
        lemonView.addSubview(oneBtn)
        lemonView.addSubview(threeBtn)
        lemonView.addSubview(twoBtn)
        
        whiteView.addSubview(tableView)
        
        bgImageView.snp.makeConstraints { make in
            make.top.leading.right.equalToSuperview()
            make.height.equalTo(279)
        }
        headView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(StatusBarHeight + 50)
        }
        whiteView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(50)
            make.left.right.bottom.equalToSuperview()
        }
        lemonView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(whiteView.snp.top).offset(-30)
            make.size.equalTo(CGSize(width: 343, height: 90))
        }
        oneBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(48)
            make.top.equalToSuperview().offset(21)
            make.size.equalTo(CGSize(width: 34, height: 50))
        }
        threeBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-47)
            make.top.equalToSuperview().offset(21)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        twoBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.left.equalTo(oneBtn.snp.right)
            make.right.equalTo(threeBtn.snp.left)
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(lemonView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview().offset(-2)
        }
        
        modelArray.compactMap { $0 ?? [] }.asObservable().bind(to: tableView.rx.items(cellIdentifier: "OrderViewCell", cellType: OrderViewCell.self)) { index, model, cell in
            cell.model.accept(model)
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
        }.disposed(by: disposeBag)
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension OrderView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        whiteView.setTopCorners(radius: 20)
        oneBtn.layoutButtonEdgeInsets(style: .top, space: 11)
        twoBtn.layoutButtonEdgeInsets(style: .top, space: 14)
        threeBtn.layoutButtonEdgeInsets(style: .top, space: 11)
    }
    
}


extension OrderView: UITableViewDelegate {
    
    
    
    
}
