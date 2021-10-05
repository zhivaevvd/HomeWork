//
//  Order.swift
//  SchoolStore
//
//  Created by a1 on 04.10.2021.
//

import Foundation

struct Order: Decodable {
    let id: String
    let number: Int
    let product_id: String
    let product_preview: String
    let product_quantity: Int
    let product_size: String
    let created_at: String
    let etd: String
    let delivery_address: String
    let status: String
}
