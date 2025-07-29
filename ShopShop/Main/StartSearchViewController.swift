//
//  StartSearchViewController.swift
//  ShopShop
//
//  Created by yk on 7/28/25.
//

import UIKit
import SnapKit

class StartSearchViewController: UIViewController {

    let mainView = StartView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.search.delegate = self
    }
}

extension StartSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let vc = ResultViewController()
        
        guard var searchText = mainView.search.text, searchText.count > 1 else {
            // alert
            print("두글자 이상 입력해주세요")
            return
        }
        // 옵셔널처리하기
        vc.text = searchText
        navigationController?.pushViewController(vc, animated: true)
    }
}
