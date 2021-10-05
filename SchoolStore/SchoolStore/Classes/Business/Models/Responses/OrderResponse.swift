//
//  OrderResponse.swift
//  SchoolStore
//
//  Created by a1 on 04.10.2021.
//

import Foundation

struct CheckoutResponse: Decodable {
    let order: Order
}

struct OrdersResponse: Decodable {
    let orders: [Order]
}
