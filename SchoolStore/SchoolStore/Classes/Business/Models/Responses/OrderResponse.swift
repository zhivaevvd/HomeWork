//
//  OrderResponse.swift
//  SchoolStore
//
//  Created by a1 on 14.10.2021.
//

import Foundation

struct ArrangeOrderResponse: Decodable {
    let order: Order
}

struct GetListOfOrdersResponse: Decodable {
    let orders: [Order]
}
