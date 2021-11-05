//
//  NewOrder.swift
//  SchoolStore
//
//  Created by a1 on 04.11.2021.
//

import Foundation

struct NewOrder: Decodable, Hashable, Equatable {
    let id: String
    let number: Int
    let productId: String
    let productPreview: String
    let productQuantity: Int
    let productSize: String
    let createdAt: String
    let etd: String
    let deliveryAddress: String
    let status: OrderStatus
}
