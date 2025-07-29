//
//  NetworkManager.swift
//  ShopShop
//
//  Created by yk on 7/29/25.
//
import UIKit
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func callRequest(query: String,
                     sort: String,
                     page: Int,
                     success: @escaping (ShopList) -> Void,
                     fail: @escaping () -> Void)
                    {
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(query)&display=30&sort=\(sort)&start=\(page)"
        
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.naverId,
            "X-Naver-Client-Secret": APIKey.naverSecret
        ]
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ShopList.self) { response in
                switch response.result {
                case .success(let value):
                    success(value)
                    
                case .failure(let error):
                    // 알림창띄우기
                    
                    
                    fail()
                }
                
            }
        
    }
}
