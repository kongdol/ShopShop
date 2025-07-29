//
//  SecondCell.swift
//  ShopShop
//
//  Created by yk on 7/30/25.
//

import UIKit

class SecondCell: BaseViewCell {
    
    static let identifier = "SecondCell"
    
    
    var secondLabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(secondLabel)
        
    }
    
    override func configureLayout() {
        secondLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().offset(8)
        }
    }
    
    override func configureView() {
        secondLabel.text = "테스트"
    }
}
