//
//  BaseView.swift
//  ShopShop
//
//  Created by yk on 7/29/25.
//

import UIKit

class BaseView: UIView, ViewDesignProtocol {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
     
        configureHierarchy()
        configureLayout()
        configureView()
    }
    func configureHierarchy() {}
    
    func configureLayout() {}
    
    func configureView() {}

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init")
    }
}
