//
//  CatalogResponse.swift
//  SchoolStore
//
//  Created by a1 on 04.10.2021.
//

import Foundation

struct ProductsResponse: Decodable {
    let products: [Item]
}

struct ProductDetailInfoResponse: Decodable {
    let product: Item
}
