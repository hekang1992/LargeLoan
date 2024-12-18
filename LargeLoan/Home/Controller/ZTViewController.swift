//
//  ZTViewController.swift
//  LargeLoan
//
//  Created by 何康 on 2024/12/19.
//

import UIKit

class ZTViewController: BaseViewController {
    
    var model: BaseModel? {
        didSet {
            guard let model = model else { return }
            print("model======\(model.exuding.guess?.pungent ?? "")")
        }
    }
    
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
        
        view.addSubview(self.headView)
        self.headView.bgView.backgroundColor = .clear
        self.headView.namelabel.text = "Verify Step"
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
