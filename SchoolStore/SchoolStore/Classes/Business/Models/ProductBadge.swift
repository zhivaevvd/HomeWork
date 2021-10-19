//
//  ProductBadge.swift
//  SchoolStore
//
//  Created by a1 on 14.10.2021.
//

import Foundation

struct ProductBadge: Decodable {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        value = try container.decode(String.self, forKey: CodingKeys.value)
        color = try container.decode(String.self, forKey: CodingKeys.value)
    }
    
    enum CodingKeys: String, CodingKey {
        case value, color
    }
    
    let value: String
    let color: String
}
