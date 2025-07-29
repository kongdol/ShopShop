//
//  BaseCeollectionViewCell.swift
//  ShopShop
//
//  Created by yk on 7/29/25.
//

import UIKit

class BaseCeollectionViewCell: BaseViewCell {
    var imageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    var mallName = {
        let mallName = UILabel()
        mallName.font = .systemFont(ofSize: 12)
        mallName.textColor = .lightGray
        return mallName
    }()
    
    var title = {
        let title = UILabel() //2줄까지보여짐
        title.font = .boldSystemFont(ofSize: 14)
        title.textColor = .white
        title.numberOfLines = 2
        return title
    }()
    
    var Iprice = {
        let IPrice = UILabel()
        IPrice.font = .boldSystemFont(ofSize: 16)
        IPrice.textColor = .white
        return IPrice
    }()
    
    var heartButton = {
        let heartButton = UIButton()
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        heartButton.tintColor = .black
        heartButton.backgroundColor = .white
        heartButton.layer.cornerRadius = 16
        heartButton.clipsToBounds = true
        return heartButton
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(mallName)
        contentView.addSubview(title)
        contentView.addSubview(Iprice)
        contentView.addSubview(heartButton)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            //make.horizontalEdges.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(8) // 셀의 왼쪽에서 8pt 간격
            make.trailing.equalToSuperview().inset(8) // 셀의 오른쪽에서 8pt 간격 (안쪽으로)
            make.height.equalTo(imageView.snp.width)
        }
        
        heartButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(-48)
            make.trailing.equalTo(imageView).inset(8)
            make.width.height.equalTo(32)
        }
        
        mallName.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(mallName.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        Iprice.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(8)
            make.bottom.equalTo(contentView.snp.bottom).offset(-8)
            make.leading.trailing.equalToSuperview().inset(8)
        }
    }
    
    override func configureView() {
        
    }
}
