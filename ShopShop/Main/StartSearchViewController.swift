//
//  StartSearchViewController.swift
//  ShopShop
//
//  Created by yk on 7/28/25.
//

import UIKit
import SnapKit

class StartSearchViewController: UIViewController {

    let titleLabel = UILabel()
    let search = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    


}

extension StartSearchViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(search)
    }
    
    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(72)
            make.height.equalTo(32)
        }
        
        search.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().offset(8)
        }
        
    }
    
    func configureView() {
        titleLabel.text = "영캠러의 쇼핑쇼핑"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        
        search.placeholder = "브랜드, 상품, 프로필, 태그 등"
        search.searchBarStyle = .minimal
        search.backgroundColor = .black
        search.searchTextField.textColor = .white
    }
    
    
    
    
}
