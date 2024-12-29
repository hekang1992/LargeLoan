//
//  MainView.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/15.
//

import UIKit
import RxRelay
import TYCyclePagerView
import RxSwift

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
    
    lazy var importView: TYCyclePagerView = {
        let importView = TYCyclePagerView()
        importView.delegate = self
        importView.dataSource = self
        importView.isInfiniteLoop = true
        importView.autoScrollInterval = 2
        importView.register(MainCycleCell.self,
                            forCellWithReuseIdentifier: "MainCycleCell")
        return importView
    }()
    
    lazy var notimpView: TYCyclePagerView = {
        let notimpView = TYCyclePagerView()
        notimpView.delegate = self
        notimpView.dataSource = self
        notimpView.isInfiniteLoop = true
        notimpView.autoScrollInterval = 2
        notimpView.register(SunViewCell.self,
                            forCellWithReuseIdentifier: "SunViewCell")
        return notimpView
    }()
    
    var model = BehaviorRelay<BaseModel?>(value: nil)
    
    var headmodel = BehaviorRelay<BaseModel?>(value: nil)
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 60
        tableView.delegate = self
        tableView.showsHorizontalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
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
        mainView.addSubview(importView)
        mainView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(StatusBarHeight + 10)
            make.size.equalTo(CGSize(width: SCREEN_WIDTH - 32, height: 120))
            make.centerX.equalToSuperview()
        }
        importView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        if model?.something?.count ?? 0 > 0 {
            subView.isHidden = false
            headView.addSubview(subView)
            subView.addSubview(tiIcon)
            subView.addSubview(liIcon)
            subView.addSubview(notimpView)
            subView.snp.makeConstraints { make in
                make.top.equalTo(mainView.snp.bottom).offset(10)
                make.size.equalTo(CGSize(width: 345, height: 56))
                make.centerX.equalToSuperview()
            }
            tiIcon.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            liIcon.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset(14)
                make.size.equalTo(CGSize(width: 22, height: 26))
            }
            notimpView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(liIcon.snp.right).offset(12)
                make.right.equalToSuperview()
                make.top.equalToSuperview()
            }
        }else {
            subView.isHidden = true
        }
        return headView
    }
    
    
}


extension HomeMainView: TYCyclePagerViewDelegate, TYCyclePagerViewDataSource {
    
    func numberOfItems(in pagerView: TYCyclePagerView) -> Int {
        if pagerView == importView {
            return headmodel.value?.exuding.cut?.something?.count ?? 0
        }else {
            return headmodel.value?.exuding.knelt?.something?.count ?? 0
        }
    }
    
    func pagerView(_ pagerView: TYCyclePagerView, cellForItemAt index: Int) -> UICollectionViewCell {
        if pagerView == importView {
            guard let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "MainCycleCell", for: index) as? MainCycleCell else { return UICollectionViewCell() }
            if let allUrl = headmodel.value?.exuding.cut?.something {
                let model = allUrl[index]
                cell.ipoImgaView.kf.setImage(with: URL(string: model.oozing ?? ""))
            }
            return cell
        }else {
            guard let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "SunViewCell", for: index) as? SunViewCell else { return UICollectionViewCell() }
            if let wentUrl = headmodel.value?.exuding.knelt?.something{
                let model = wentUrl[index]
                cell.mlabel.text = model.coldly ?? ""
                cell.mlabel.textColor = UIColor.init(cssStr: model.failed ?? "#000000")
                cell.delabel.text = model.repay_btn_text ?? ""
            }
            return cell
        }
        
    }
    
    func pagerView(_ pagerView: TYCyclePagerView, didSelectItemAt index: Int) {
        
    }
    
    func layout(for pagerView: TYCyclePagerView) -> TYCyclePagerViewLayout {
        let layout = TYCyclePagerViewLayout()
        if pagerView == importView {
            layout.itemSize = CGSizeMake(SCREEN_WIDTH - 32, 120)
            layout.itemSpacing = 5
            return layout
        }else {
            layout.itemSize = CGSizeMake(SCREEN_WIDTH - 70, 56)
            layout.itemSpacing = 5
            return layout
        }
    }
    
}
