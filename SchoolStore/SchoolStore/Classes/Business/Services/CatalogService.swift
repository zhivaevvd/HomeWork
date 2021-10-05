//
//  CatalogService.swift
//  SchoolStore
//
//  Created by a1 on 30.09.2021.
//

import Foundation

protocol CatalogService: AnyObject {
    func someFunc()
}

final class CatalogServiceIml: CatalogService {
    
    init() {}
    
    func someFunc() {}
}
