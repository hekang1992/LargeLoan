//
//  LoginViewController.swift
//  LargeLoan
//
//  Created by 何康 on 2024/12/14.
//

import UIKit

class LoginViewController: BaseViewController {
    
    private var loginView = LoginView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tapClick()
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

extension LoginViewController {
    
    func tapClick() {
        
        loginView.loginBtn.rx.tap.subscribe(onNext: { [weak self] in
            PushRootVcConfig.goRootVc()
        }).disposed(by: disposeBag)
        
    }
    
    
}
