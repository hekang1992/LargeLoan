//
//  EnterWordsCell.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/23.
//

import UIKit

class EnterWordsCell: BaseTableViewCell {

    static let reuseIdentifier = String(describing: EnterWordsCell.self)
    
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
