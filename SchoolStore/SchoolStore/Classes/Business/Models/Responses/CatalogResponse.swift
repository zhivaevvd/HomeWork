//
//  CatalogResponse.swift
//  SchoolStore
//
//  Created by a1 on 14.10.2021.
//

import Foundation

struct GetListOfProductResponse: Decodable {
    let products: [Product]
}

struct GetDetailInfoResponse: Decodable {
    let product: Product
}
