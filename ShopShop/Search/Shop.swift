//
//  File.swift
//  ShopShop
//
//  Created by yk on 7/29/25.
//

import Foundation

struct ShopList: Decodable {
    let total: Int
    let items: [ShopData]
}

struct ShopData: Decodable {
    let title: String
    let image: String
    let mallName: String
    let lprice: String
}
