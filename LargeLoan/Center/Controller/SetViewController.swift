//
//  SetViewController.swift
//  LargeLoan
//
//  Created by 何康 on 2024/12/15.
//

import UIKit

class SetViewController: BaseViewController {
    
    lazy var homeImageView: UIImageView = {
        let homeImageView = UIImageView()
        homeImageView.image = UIImage(named: "homebg")
        homeImageView.isUserInteractionEnabled = true
        return homeImageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(homeImageView)
        homeImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        homeImageView.addSubview(self.headView)
        self.headView.namelabel.text = "Set Up"
        self.headView.bgView.backgroundColor = .clear
        headView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(StatusBarHeight + 50)
        }
        
        backInfo()
        
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

extension SetViewController {
    
    
    
}
