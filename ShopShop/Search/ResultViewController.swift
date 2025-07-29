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
    
    let resultView = ResultView()
    
    var list: [ShopData] = []
    var secondList: [ShopData] = []
    
    var page = 1
    
    var isEnd = false
    
    var text: String?
    var sort = "sim"
    var totalpage = 0
    
    override func loadView() {
        self.view = resultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultView.collectionView.delegate = self
        resultView.collectionView.dataSource = self
        
        resultView.twoCollectionView.delegate = self
        resultView.twoCollectionView.dataSource = self
        
        
        guard let text = text else {
            print("text값이 없어요")
            return
        }
        
        resultView.accButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        resultView.dateButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        resultView.highButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        resultView.lowButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        
        callRequest(query: text)
        twoCallRequest()
        
    }
    
    func twoCallRequest() {
        NetworkManager().secondCallRequest { value in
            print(value)
            
            self.secondList.append(contentsOf: value.items)
            self.resultView.twoCollectionView.reloadData()
        } fail: {
            print("실패")
        }

    }
    
    
    
    func callRequest(query: String) {
        NetworkManager().callRequest(query: query, sort: sort, page: page) { value in
            //print("성공", value)
            
//            if value.total == 0 {
//                self.navigationController?.popViewController(animated: true)
//                break
//            }
            
            self.resultView.totalLabel.text = "\(value.total.formatted()) 개의 검색 결과"
            self.list.append(contentsOf: value.items)
            self.resultView.collectionView.reloadData()
            
            if self.page == 1 {
                self.resultView.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
            
            self.totalpage = (value.total/value.display)
            print(self.totalpage)
            
        } fail: {
            self.showAlert(title: "네트워크 통신이 실패했습니다.", message: "인터넷을 확인해주세요") {
                self.navigationController?.popViewController(animated: true)
            }
            print("실패")
        }
        
    }
    
    @objc func sortButtonTapped(sender: UIButton) {
        if sender == resultView.accButton {
            sort = "sim"
        } else if sender == resultView.dateButton {
            sort = "date"
        } else if sender == resultView.highButton {
            sort = "dsc"
        } else if sender == resultView.lowButton {
            sort = "asc"
        }
        
        guard let text = text else {
            print("text값이 없어요")
            return
        }
        
        list.removeAll()
        
        page = 1
        
        callRequest(query: text)
    }
}




extension ResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == resultView.collectionView {
            return list.count
        } else {
            return secondList.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == resultView.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BaseCeollectionViewCell", for: indexPath) as! BaseCeollectionViewCell
            
            cell.backgroundColor = .clear
            cell.mallName.text = list[indexPath.item].mallName
            cell.title.text = list[indexPath.item].title
            cell.Iprice.text = Int(list[indexPath.item].lprice)?.formatted()
            
            let url = URL(string: list[indexPath.item].image)
            cell.imageView.kf.setImage(with: url)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondCell.identifier, for: indexPath) as! SecondCell
            
            cell.backgroundColor = .red
            cell.secondLabel.text = secondList[indexPath.item].title
        
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(#function, indexPath)
        
        if indexPath.item == (list.count - 3) && isEnd == false {
            page += 1
            callRequest(query: text!)
        }
        
        print("현재페이지\(self.page), 전체페이지 \(totalpage)")
        
        if totalpage == self.page{
            isEnd = true
            print("굿")
//            self.showAlert(title: "마지막페이지", message: "더이상보여줄게없어요") {
//            
//            }
        }
    }
    
}


