//
//  CatalogRequests.swift
//  SchoolStore
//
//  Created by a1 on 04.10.2021.
//

import Foundation

enum CatalogRequest: Request {
    case items
    case itemDetailInfo
    
    var path: String {
        switch self {
        case .items:
            return "products"
        case .itemDetailInfo:
            return "products/{product_id}"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .items, .itemDetailInfo:
            return .get
        }
    }
    
    var mock: Data? {
        switch self {
        case .items:
            guard let path = Bundle.main.path(forResource: "items", ofType: "json"),
                  let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                  else {
                return nil
            }
            return data
        case .itemDetailInfo:
            guard let path = Bundle.main.path(forResource: "itemDetailInfo", ofType: "json"),
                  let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                  else {
                return nil
            }
            return data
        }
    }
}
