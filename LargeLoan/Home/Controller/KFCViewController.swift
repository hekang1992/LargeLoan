//
//  KFCViewController.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/19.
//

import UIKit
import RxRelay
import RxDataSources

struct SectionModel {
    var header: String
    var items: [String]
}

extension SectionModel: SectionModelType {
    typealias Item = String
    
    init(original: SectionModel, items: [String]) {
        self = original
        self.items = items
    }
}


class KFCViewController: BaseViewController {
    
    var array: [[String]]? {
        didSet {
            
        }
    }
    
    var productID: String? {
        didSet {
            guard let productID = productID else { return }
        }
    }
    
    private var arrayRelay = BehaviorRelay<[SectionModel]>(value: [])
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 40
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(KFCTableViewCell.self, forCellReuseIdentifier: "KFCTableViewCell")
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
        backInfo()
        view.addSubview(self.headView)
        self.headView.lemonView.backgroundColor = .clear
        self.headView.namelabel.text = "E-KYC"
        headView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(StatusBarHeight + 50)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(headView.snp.bottom)
        }
        tableView.layoutIfNeeded()
        tableView.setTopCorners(radius: 20)
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        let sections = array?.enumerated().map { index, items -> SectionModel in
            return SectionModel(header: "Section \(index + 1)", items: items)
        }
        
        arrayRelay.accept(sections ?? [])
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel>(
            configureCell: { (dataSource, tableView, indexPath, item) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "KFCTableViewCell", for: indexPath) as? KFCTableViewCell
                cell?.bigManLabel.text = item
                return cell ?? UITableViewCell()
            }
        )
        
        arrayRelay.asObservable().bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self).subscribe(onNext: { [weak self] type in
            guard let self = self else { return }
            self.closingTime = CurrentTimeManager.getCurrentTime()
            self.exprwssinfo()
            let phoVc = PhotoViewController()
            phoVc.type = type
            phoVc.productID = self.productID
            self.navigationController?.pushViewController(phoVc, animated: true)
        }).disposed(by: disposeBag)
        
        openTime = CurrentTimeManager.getCurrentTime()
        
    }
    
}


extension KFCViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let label = UILabel()
        label.textAlignment = .left
        label.font = .mediumFontOfSize(size: 16)
        label.textColor = .init(colorHexStr: "#2B170A")
        headerView.backgroundColor = .init(colorHexStr: "#FFDFCA")
        if section == 0 {
            label.text = "Recommended ID Type"
        } else {
            label.text = "Other Options"
        }
        headerView.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(20)
        }
        return headerView
    }
    
    
    
}

extension KFCViewController {
    
    func exprwssinfo() {
        self.expressioninfo(from: self.productID ?? "",
                            continued: "2",
                            openTime: self.openTime,
                            closingTime: self.closingTime)
    }
    
}
