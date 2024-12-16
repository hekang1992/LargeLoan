//
//  BaseViewController.swift
//  LargeLoan
//
//  Created by 何康 on 2024/12/12.
//

import UIKit
import RxSwift
import Moya

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let provider = MoyaProvider<LargeLoanAPI>()
    
    lazy var headView: HeadView = {
        let headView = HeadView()
        return headView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
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


extension BaseViewController {
    
    
    func backInfo() {
        self.headView.backBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
    }
    
}
