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
    var totalLabel = UILabel()
    
    //정렬버튼
    var accButton = UIButton()
    var dateButton = UIButton()
    var highButton = UIButton()
    var lowButton = UIButton()
    
    var page = 1
    
    var text: String?
    var sort = "sim"
    
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
        
        accButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        dateButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        highButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        lowButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        
        callRequest(query: text, sort: sort)
    }
    
    @objc func sortButtonTapped(sender: UIButton) {
        if sender == accButton {
            sort = "sim"
        } else if sender == dateButton {
            sort = "date"
        } else if sender == highButton {
            sort = "dsc"
        } else if sender == lowButton {
            sort = "asc"
        }
        
        guard let text = text else {
            print("text값이 없어요")
            return
        }
        
        list.removeAll()
      
        page = 1
        callRequest(query: text, sort: sort)
    }
    
    func callRequest(query: String, sort: String) {
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(query)&display=30&sort=\(sort)&start=\(page)"
        
        
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": "pmzQ1zbWLtTODTRCawFo",
            "X-Naver-Client-Secret": "bNRd8LrMd9"
        ]
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ShopList.self) { response in
                switch response.result {
                case .success(let value):
                    self.totalLabel.text = "\(value.total.formatted()) 개의 검색 결과"
                    self.list.append(contentsOf: value.items)
                    //self.list = value.items
                    self.collectionView.reloadData()
                    
                    
                    if self.page == 1 {
                        self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                    }
                    
                    
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
        
        view.addSubview(stackView)
        [accButton, dateButton, highButton, lowButton].forEach{stackView.addArrangedSubview($0)}
    }
    
    func configureLayout() {
        totalLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
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
    
    func configureView() {
        title = text
        
        view.backgroundColor = .darkGray
        
        totalLabel.textColor = .green
        
        accButton.setTitle("정확도", for: .normal)
        accButton.setTitleColor(.white, for: .normal)
        accButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        accButton.layer.borderWidth = 1
        accButton.layer.borderColor = UIColor.white.cgColor
        accButton.layer.cornerRadius = 12
        accButton.clipsToBounds = true
        
        
        dateButton.setTitle("날짜순", for: .normal)
        dateButton.setTitleColor(.white, for: .normal)
        dateButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        dateButton.layer.borderWidth = 1
        dateButton.layer.borderColor = UIColor.white.cgColor
        dateButton.layer.cornerRadius = 12
        dateButton.clipsToBounds = true
      
        
        highButton.setTitle("가격높은순", for: .normal)
        highButton.setTitleColor(.white, for: .normal)
        highButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        highButton.layer.borderWidth = 1
        highButton.layer.borderColor = UIColor.white.cgColor
        highButton.layer.cornerRadius = 12
        highButton.clipsToBounds = true
       
        
        lowButton.setTitle("가격낮은순", for: .normal)
        lowButton.setTitleColor(.white, for: .normal)
        lowButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        lowButton.layer.borderWidth = 1
        lowButton.layer.borderColor = UIColor.white.cgColor
        lowButton.layer.cornerRadius = 12
        lowButton.clipsToBounds = true
    }
    
    
}

extension ResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCollectionViewCell", for: indexPath) as! ResultCollectionViewCell
        
        cell.backgroundColor = .clear
        cell.mallName.text = list[indexPath.item].mallName
        cell.title.text = list[indexPath.item].title
        cell.Iprice.text = Int(list[indexPath.item].lprice)?.formatted()
        
        let url = URL(string: list[indexPath.item].image)
        cell.imageView.kf.setImage(with: url)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //print(#function, indexPath)
        
        if indexPath.item == (list.count - 3) {
            page += 1
            callRequest(query: text!, sort: sort)
        }
    }
    
}


