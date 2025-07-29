//
//  ResultVIew.swift
//  ShopShop
//
//  Created by yk on 7/29/25.
//

import UIKit
import SnapKit

class ResultView: BaseView {
    
  
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.minimumInteritemSpacing = 8 // 셀 너비 간격
        layout.minimumLineSpacing = 8 // 셀 높이 간격
        layout.scrollDirection = .vertical
        
        let deviceWidth = UIScreen.main.bounds.width
        // 바깥쪽 2개 안쪽 1개 -> 한줄에 2개
        let cellWidth = deviceWidth - (16 * 2) - (16 * 1)
        layout.itemSize = CGSize(width: cellWidth / 2, height: (cellWidth / 2) * 1.5)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BaseCeollectionViewCell.self, forCellWithReuseIdentifier: "BaseCeollectionViewCell")
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    lazy var stackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    //전체갯수
    var totalLabel = {
        let totalLabel = UILabel()
        totalLabel.textColor = .green
        return totalLabel
    }()
    
    //정렬버튼
    var accButton =  {
        let accButton = SortButton(title: "정확도")
        return accButton
    }()
    
    var dateButton = {
        let dateButton = SortButton(title: "날짜순")
       
        
        return dateButton
    }()
    
    var highButton = {
        let highButton = SortButton(title: "가격높은순")
        return highButton
    }()
    
    var lowButton = {
        let lowButton = SortButton(title: "가격낮은순")
        return lowButton
    }()
    
    override func configureHierarchy() {
        self.addSubview(totalLabel)
        self.addSubview(collectionView)
        
        self.addSubview(stackView)
        [accButton, dateButton, highButton, lowButton].forEach{stackView.addArrangedSubview($0)}
    }
    
    override func configureLayout() {
        totalLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(8)
            make.leading.equalToSuperview().offset(8)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-80)
            make.height.equalTo(32)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(16)
            make.bottom.equalToSuperview().offset(-8)
            make.leading.trailing.equalToSuperview().inset(8)
        }
    }
    
    override func configureView() {
        self.backgroundColor = .darkGray
        //title = text
    }
}
