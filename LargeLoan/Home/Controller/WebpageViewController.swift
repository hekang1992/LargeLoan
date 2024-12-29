//
//  WebpageViewController.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/28.
//

import UIKit
import RxRelay
@preconcurrency import WebKit
import StoreKit

class WebpageViewController: BaseViewController {
    
    var webUrl = BehaviorRelay<String>(value: "")
    
    lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
        let scriptNames = ["peachTeaS", "eelPalmAc", "kangarooS", "appleCila", "sorbetVul", "okraPiano"]
        scriptNames.forEach { userContentController.add(self, name: $0) }
        configuration.userContentController = userContentController
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.scrollView.apply {
            $0.bounces = false
            $0.alwaysBounceVertical = false
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.contentInsetAdjustmentBehavior = .never
        }
        webView.navigationDelegate = self
        return webView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        view.addSubview(homeImageView)
        homeImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(self.headView)
        self.headView.lemonView.backgroundColor = .clear
        headView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(StatusBarHeight + 50)
        }
        
        self.headView.backBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            if self.webView.canGoBack {
                self.webView.goBack()
            }else {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }).disposed(by: disposeBag)
        
        
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(1)
            make.left.right.bottom.equalToSuperview()
        }
        
        if let url = URL(string: webUrl.value) {
            webView.load(URLRequest(url: url))
        }
        
        webView.rx.observe(String.self, "title")
            .subscribe(onNext: { [weak self] title in
                DispatchQueue.main.async {
                    self?.headView.namelabel.text = title ?? ""
                }
            }).disposed(by: disposeBag)
        
    }
    
}

extension WebpageViewController: WKScriptMessageHandler, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        LoadingIndicator.shared.showLoading()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        LoadingIndicator.shared.hideLoading()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        LoadingIndicator.shared.hideLoading()
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let messageName = message.name
        print("message:\(message.name)")
        if messageName == "peachTeaS" {
            let body = message.body as? [String]
            let productID = body?.first ?? ""
            let openTime = body?.last ?? ""
            exnineoinf(from: productID, openTime: openTime)
        }else if messageName == "okraPiano" {
            DispatchQueue.main.async {
                if #available(iOS 14.0, *) {
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        SKStoreReviewController.requestReview(in: windowScene)
                    }
                } else {
                    SKStoreReviewController.requestReview()
                }
            }
        }else if messageName == "appleCila" {
            PushRootVcConfig.goRootVc()
        }else if messageName == "kangarooS" {
            self.navigationController?.popViewController(animated: true)
        }else if messageName == "sorbetVul" {
            
        }else if messageName == "eelPalmAc" {
            guard let array = message.body as? [String], let pageUrl = array.first else { return }
            if !pageUrl.isEmpty, pageUrl.hasPrefix(urlScheme), let sc = URL(string: pageUrl) {
                if let productId = self.jiequzifu(url: sc) {
                    self.getProductDetailInfo(form: productId, complete: { [weak self] model in
                        let older = model.exuding.her?.older ?? ""
                        if let guess = model.exuding.guess, let pungent = guess.pungent, !pungent.isEmpty  {
                            let pushVc = ZTViewController()
                            pushVc.model = model
                            pushVc.proid = productId
                            self?.navigationController?.pushViewController(pushVc, animated: true)
                        }else {
                            self?.ddOrderinfo(from: older)
                        }
                    })
                }
            }else {
                LoadingIndicator.shared.hideLoading()
                self.pushnetwork(from: pageUrl)
            }
        }
    }
    
}

extension UIScrollView {
    func apply(_ configuration: (UIScrollView) -> Void) {
        configuration(self)
    }
}

extension WebpageViewController {
    
    func exnineoinf(from productID: String, openTime: String) {
        self.expressioninfo(from: productID,
                            continued: "10",
                            openTime: openTime,
                            closingTime: CurrentTimeManager.getCurrentTime())
    }
    
}
