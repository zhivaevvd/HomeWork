//
//  CatalogService.swift
//  SchoolStore
//
//  Created by a1 on 14.10.2021.
//

import Foundation
import UIKit

protocol CatalogService: AnyObject {
    func getListOfProducts(completion: ((Result<[Product], Error>) -> Void)?)
}

final class CatalogServiceImpl: CatalogService {
    
    typealias catalog = DataResponse<GetListOfProductResponse>
    
//    func getListOfProducts(completion: ((Result<[Product], Error>) -> Void)?) {
//        networkProvider.mock(CatalogRequest.listOfProducts, completion: {
//            (result: Result<catalog, Error>) in
//            switch result {
//            case let .success(data):
//                completion?(Result.success(data.data.products))
//            case let .failure(error):
//                completion?(Result.failure(error))
//            }
//        })
//    }
    
    func getListOfProducts(completion: ((Result<[Product], Error>) -> Void)?) {
        networkProvider.mock(CatalogRequest.listOfProducts, completion: {
            (result: Result<catalog, Error>) in
            switch result {
            case .success:
                completion?(result.map({ obj in obj.data.products }))
            case let .failure(error):
                completion?(Result.failure(error))
            }
        })
    }
    
    
    
    init(networkProvider: NetworkProvider) {
        self.networkProvider = networkProvider
    }
    
    private let networkProvider: NetworkProvider

}
