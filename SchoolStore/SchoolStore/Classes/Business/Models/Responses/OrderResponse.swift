//
//  OrderResponse.swift
//  SchoolStore
//
//  Created by a1 on 21.10.2021.
//

import Foundation

struct OrderResponse: Decodable {
    let orders: [Order]
}

struct CreateOrder: Decodable {
    let order: NewOrder
}
