//
//  Item.swift
//  SchoolStore
//
//  Created by a1 on 04.10.2021.
//

import Foundation

struct Item: Decodable {
    let id: String
    let title: String
    let department: String
    let price: Int
    let badge: ItemBadge
    let preview: String
    let images: [String]
    let sizes: [ItemSize]
    let description: String
    let details: [String]
}
