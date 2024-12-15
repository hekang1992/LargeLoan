//
//  HomeViewController.swift
//  LargeLoan
//
//  Created by 何康 on 2024/12/14.
//

import UIKit

class HomeViewController: BaseViewController {
    
    lazy var subView: HomeSubView = {
        let subView = HomeSubView()
        return subView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
