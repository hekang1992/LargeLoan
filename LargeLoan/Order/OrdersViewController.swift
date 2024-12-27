//
//  OrdersViewController.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/14.
//

import UIKit

class OrdersViewController: UIViewController {
    
    lazy var orView: OrderView = {
        let orView = OrderView()
        return orView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(orView)
        orView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
