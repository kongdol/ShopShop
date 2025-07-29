//
//  SortButton.swift
//  ShopShop
//
//  Created by yk on 7/29/25.
//

import UIKit

class SortButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(title: String) {
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
    }
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("커스텀버튼문제")
    }
}
