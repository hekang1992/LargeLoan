//
//  PhotoViewController.swift
//  LargeLoan
//
//  Created by 何康 on 2024/12/20.
//

import UIKit

class PhotoViewController: BaseViewController {
    
    var type: String? {
        didSet {
            guard let type = type else { return }
            print("type========\(type)")
        }
    }
    
    var productID: String? {
        didSet {
            guard let productID = productID else { return }
            print("photo====productID======\(productID)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(homeImageView)
        homeImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(self.headView)
        self.headView.bgView.backgroundColor = .clear
        self.headView.namelabel.text = "Identity Information"
        headView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(StatusBarHeight + 50)
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
