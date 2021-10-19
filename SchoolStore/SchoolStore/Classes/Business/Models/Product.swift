//
//  Product.swift
//  SchoolStore
//
//  Created by a1 on 14.10.2021.
//

import Foundation

struct Product: Decodable {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: CodingKeys.id)
        title = try container.decode(String.self, forKey: CodingKeys.title)
        price = try container.decode(Int.self, forKey: CodingKeys.price)
        department = try container.decode(String.self, forKey: CodingKeys.department)
        description = try container.decode(String.self, forKey: CodingKeys.description)
        preview = try container.decode(String.self, forKey: CodingKeys.preview)
        details = try container.decode([String].self, forKey: CodingKeys.details)
        images = try container.decode([String].self, forKey: CodingKeys.images)
        sizes = try container.decode([ProductSize].self, forKey: CodingKeys.sizes)
        badge = try container.decode(ProductBadge.self, forKey: CodingKeys.badge)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case department
        case description
        case preview
        case details
        case images
        case sizes
        case badge
    }
    
    
    let id: String
    let title: String
    let department: String
    let price: Int
    let preview: String
    let description: String
    let details: [String]
    let images: [String]
    let sizes: [ProductSize]
    let badge: ProductBadge
}
