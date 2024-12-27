//
//  ConLULULemonCong.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/25.
//

import UIKit

class ConLULULemonCong: NSObject {

    static func tpuType(from tpu: String, old: String, vc: BaseViewController) {
        if tpu == "solargeg" {
            let oneVc = AuthYIViewController()
            oneVc.productID = old
            vc.navigationController?.pushViewController(oneVc, animated: true)
        }else if tpu == "solargeh" {
            let oneVc = AVTEViewController()
            oneVc.productID = old
            vc.navigationController?.pushViewController(oneVc, animated: true)
        }else if tpu == "solargei" {
            let oneVc = ConLULUlemonViewController()
            oneVc.productID = old
            vc.navigationController?.pushViewController(oneVc, animated: true)
        }else if tpu == "solargej" {
            let oneVc = GoldenViewController()
            oneVc.productID = old
            vc.navigationController?.pushViewController(oneVc, animated: true)
        }
        
    }
    
    
}
