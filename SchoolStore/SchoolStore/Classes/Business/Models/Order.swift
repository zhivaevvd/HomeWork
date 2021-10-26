// HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

struct Order: Decodable, Hashable, Equatable {
    
//    public init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        id = try container.decode(String.self, forKey: CodingKeys.id)
//        number = try container.decode(Int.self, forKey: CodingKeys.number)
//        productId = try container.decode(String.self, forKey: CodingKeys.productId)
//        productPreview = try container.decode(String.self, forKey: CodingKeys.productPreview)
//        productQuantity = try container.decode(Int.self, forKey: CodingKeys.productQuantity)
//        productSize = try container.decode(String.self, forKey: CodingKeys.productSize)
//        createdAt = try container.decode(String.self, forKey: CodingKeys.createdAt)
//        etd = try container.decode(String.self, forKey: CodingKeys.etd)
//        deliveryAddress = try container.decode(String.self, forKey: CodingKeys.deliveryAddress)
//        status = try container.decode(OrderStatus.self, forKey: CodingKeys.status)
//        title = try container.decode(String.self, forKey: CodingKeys.title)
//    }
//    
//    enum CodingKeys: String, CodingKey {
//        case id, number, productId, productPreview, productQuantity, productSize, createdAt, etd, deliveryAddress, status, title
//    }
    
    let id: String
    let title: String
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
