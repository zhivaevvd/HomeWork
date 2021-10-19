//
//  Order.swift
//  SchoolStore
//
//  Created by a1 on 14.10.2021.
//

import Foundation

struct Order: Decodable {
    let id: String
    let number: Int
    let productId: String
    let productPreview: String
    let productQuantity: Int
    let productSize: String
    let createdAt: String
    let etd: String
    let deliveryAddress: String
    let status: String
}
