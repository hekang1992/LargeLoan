//
//  ClockWordsCell.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/23.
//

import UIKit

class ClockWordsCell: BaseTableViewCell {
    
    static let reuseIdentifier = String(describing: ClockWordsCell.self)

    lazy var enterBtnView: EnterBtnView = {
        let enterBtnView = EnterBtnView()
        return enterBtnView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(enterBtnView)
        enterBtnView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
