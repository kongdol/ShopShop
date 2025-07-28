//
//  ResultViewController.swift
//  ShopShop
//
//  Created by yk on 7/28/25.
//

import UIKit
import Alamofire
import Kingfisher

class ResultViewController: UIViewController {
    
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
        collectionView.register(ResultCollectionViewCell.self, forCellWithReuseIdentifier: ResultCollectionViewCell.identifier)
        collectionView.backgroundColor = .orange
        return collectionView
    }()
    
    //전체갯수
    var totalLabel = UILabel()
    
    var text: String?
    
    var list: [ShopData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        configureHierarchy()
        configureLayout()
        configureView()
        
        guard let text = text else {
            print("text값이 없어요")
            return
        }
        
        callRequest(query: text)
    }
    
    func callRequest(query: String) {
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(query)&display=10"
        
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": "pmzQ1zbWLtTODTRCawFo",
            "X-Naver-Client-Secret": "bNRd8LrMd9"
        ]
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ShopList.self) { response in
                switch response.result {
                case .success(let value):
                    self.totalLabel.text = "\(value.total) 개의 검색 결과"
                    self.list.append(contentsOf: value.items)
                    self.collectionView.reloadData()
                    
                case .failure(let error):
                    print(error)
                }
        
            }
//            .responseString{ response in
//                dump(response)
//            }
        
        
    }
}

extension ResultViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(totalLabel)
        view.addSubview(collectionView)
    }
    
    func configureLayout() {
        totalLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.leading.equalToSuperview().offset(8)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(16)
            make.bottom.equalToSuperview().offset(-8)
            make.leading.trailing.equalToSuperview().inset(8)
            
        }
    }
    
    func configureView() {
        title = text
        
        view.backgroundColor = .lightGray
        
        collectionView.backgroundColor = .orange
        totalLabel.textColor = .green
    }
    
    
}

extension ResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCollectionViewCell", for: indexPath) as! ResultCollectionViewCell
        
        cell.backgroundColor = .red
        cell.mallName.text = list[indexPath.item].mallName
        cell.title.text = list[indexPath.item].title
        cell.Iprice.text = list[indexPath.item].lprice
        
        let url = URL(string: list[indexPath.item].image)
        cell.imageView.kf.setImage(with: url)
        
        return cell
    }
    
    
}


