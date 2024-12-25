//
//  EnterWordsCell.swift
//  LargeLoan
//
//  Created by 何康 on 2024/12/23.
//

import UIKit

class EnterWordsCell: BaseTableViewCell {

    lazy var enterView: EnterTextView = {
        let enterView = EnterTextView()
        return enterView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(enterView)
        enterView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
