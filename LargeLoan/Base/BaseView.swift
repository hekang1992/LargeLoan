//
//  BaseView.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/12.
//

import UIKit
import RxSwift

class BaseView: UIView {

    let disposeBag = DisposeBag()
    
    let StatusBarHeight = StatusBarConfig.getStatusBarHeight()
    
    lazy var headView: HeadView = {
        let headView = HeadView()
        return headView
    }()

}
