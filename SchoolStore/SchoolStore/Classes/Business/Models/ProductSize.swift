//
//  ProductSize.swift
//  SchoolStore
//
//  Created by a1 on 14.10.2021.
//

import Foundation
import UIKit

struct ProductSize: Decodable {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        value = try container.decode(String.self, forKey: CodingKeys.value)
        is_available = try Bool(container.decode(String.self, forKey: CodingKeys.is_available))!
    }
    
    enum CodingKeys: String, CodingKey {
        case value, is_available
    }
    
    let value: String
    let is_available: Bool
}
