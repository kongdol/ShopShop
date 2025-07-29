//
//  ResultCollectionViewCell.swift
//  ShopShop
//
//  Created by yk on 7/28/25.
//

import UIKit
import SnapKit
import Alamofire

// 지금이게 쓰이는게 맞나 모르곘음,,,안쓰임,,,
class ResultCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ResultCollectionViewCell"
    
    let mainCell = BaseCeollectionViewCell()
    
    
//    override func reloadInputViews() {
//        //self.= mainCell
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        // MARK: - 이렇게하는게 맞나,,,,
        mainCell.configureHierarchy()
        mainCell.configureLayout()
        mainCell.configureView()
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init Error")
    }
}
