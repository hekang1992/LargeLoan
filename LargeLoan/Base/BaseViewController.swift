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


extension BaseViewController {
    
    
    func backInfo() {
        self.headView.backBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
    }
    
    func jiequzifu(url: URL) -> String? {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let queryItem = components.queryItems?.last,
              let value = queryItem.value else {
            return nil
        }
        return value
    }
    
    func getProductDetailInfo(form old: String, complete: @escaping ((BaseModel) -> Void)) {
        LoadingIndicator.shared.showLoading()
        provider.request(.productDetailInfo(productId: old)) { result in
            LoadingIndicator.shared.hideLoading()
            switch result {
            case .success(let response):
                do {
                    let model = try JSONDecoder().decode(BaseModel.self, from: response.data)
                    let anyone = model.anyone
                    if anyone == "0" || anyone == "0" {
                        complete(model)
                    }
                } catch {
                    print("JSON: \(error)")
                }
                break
            case .failure(_):
                break
            }
        }
    }
}
