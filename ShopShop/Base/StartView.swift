//
//  StartView.swift
//  ShopShop
//
//  Created by yk on 7/29/25.
//

import UIKit
import SnapKit

class StartView: BaseView {
    
    let titleLabel = {
        let titleLabel = UILabel()
        titleLabel.text = "영캠러의 쇼핑쇼핑"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        return titleLabel
    }()
        
    let search = {
        let search = UISearchBar()
        search.placeholder = "브랜드, 상품, 프로필, 태그 등"
        search.searchBarStyle = .minimal
        search.backgroundColor = .black
        search.searchTextField.textColor = .white
        return search
    }()
       
    
    override func configureHierarchy() {
        self.addSubview(titleLabel)
        self.addSubview(search)
    }
    
    override func configureLayout() {
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
    
    override func configureView() {
        self.backgroundColor = .black
    }
}
