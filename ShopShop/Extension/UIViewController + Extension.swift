//
//  UIViewController + Extension.swift
//  ShopShop
//
//  Created by yk on 7/29/25.
//


import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, okHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "다시해볼게요", style: .cancel) { _ in
            okHandler()
        }
        
        let ok = UIAlertAction(title: "어쩌라고", style: .default) { _ in
            self.view.backgroundColor = .red
        }
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        self.present(alert, animated: true)
    }
}
