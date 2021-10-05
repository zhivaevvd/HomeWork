//
//  OrdersRequests.swift
//  SchoolStore
//
//  Created by a1 on 04.10.2021.
//

import Foundation

enum OrderRequest: Request {
    case checkout(productId: String, size: String, quantity: Int, house: String, apartment: String, etd: String)
    case orders
    case cancel
    
    var path: String {
        switch self {
        case .checkout:
            return "orders/checkout"
        case .orders:
            return "orders"
        case .cancel:
            return "orders/{order_id}/cancel"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .checkout:
            return .post
        case .orders:
            return .get
        case .cancel:
            return .put
        }
    }
    
    var body: Data? {
        switch self {
        case let .checkout(productId, size, quantity, house, apartment, etd):
            return RequestBuilderImpl.encode(["productId": productId,
                                              "size": size,
                                              "quantity": String(quantity),
                                              "house": house,
                                              "apartment": apartment,
                                              "etd": etd])
        default:
            return nil
        }
    }
    
    var mock: Data? {
        switch self {
        case .checkout:
            guard let path = Bundle.main.path(forResource: "checkout", ofType: "json"),
                  let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            else {
                return nil
            }
            return data
        case .orders:
            guard let path = Bundle.main.path(forResource: "orders", ofType: "json"),
                  let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            else {
                return nil
            }
            return data
        default:
            return nil
        }
    }
}
