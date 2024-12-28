//
//  CenterViewController.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/14.
//

import UIKit

class CenterViewController: BaseViewController {
    
    private lazy var centerView = CenterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(centerView)
        centerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        centerView.setBtn.rx.tap.subscribe(onNext: { [weak self] in
            let setVc = SetViewController()
            self?.navigationController?.pushViewController(setVc, animated: true)
        }).disposed(by: disposeBag)
        
        centerView.oneBtn.rx.tap.subscribe(onNext: { [weak self] in
            let vc = OrdereListviewController()
            vc.type = "7"
            vc.name = "Apply Orders"
            self?.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
        
        centerView.twoBtn.rx.tap.subscribe(onNext: { [weak self] in
            let vc = OrdereListviewController()
            vc.type = "6"
            vc.name = "Repayment Orders"
            self?.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
        
        centerView.threeBtn.rx.tap.subscribe(onNext: { [weak self] in
            let vc = OrdereListviewController()
            vc.type = "5"
            vc.name = "Finished Orders"
            self?.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
        
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
