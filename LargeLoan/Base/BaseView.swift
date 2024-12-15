//
//  BaseView.swift
//  LargeLoan
//
//  Created by 何康 on 2024/12/12.
//

import UIKit
import RxSwift

class BaseView: UIView {

    let disposeBag = DisposeBag()
    
    lazy var headView: HeadView = {
        let headView = HeadView()
        return headView
    }()

}
