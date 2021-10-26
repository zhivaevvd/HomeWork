// HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

// MARK: - CatalogService

protocol CatalogService: AnyObject {
    func getCatalogItems(with offset: Int, limit: Int, completion: ((Result<[Product], Error>) -> Void)?)
    func getProduct(with id: String, completion: ((Result<Product, Error>) -> Void)?)
}

// MARK: - CatalogServiceImpl

final class CatalogServiceImpl: CatalogService {
    // MARK: Lifecycle

    init(networkProvider: NetworkProvider, dataService: DataService) {
        self.networkProvider = networkProvider
        self.dataService = dataService
    }

    // MARK: Internal

    func getCatalogItems(with offset: Int, limit: Int, completion: ((Result<[Product], Error>) -> Void)?) {
        networkProvider.mock(
            CatalogRequest.listOfProducts(offset: offset, limit: limit)
        ) { (result: Result<DataResponse<CatalogResponse>, Error>) in
            switch result {
            case .success:
                completion?(result.map(\.data.products))
            case let .failure(error):
                completion?(Result.failure(error))
            }
        }
    }

    func getProduct(with id: String, completion: ((Result<Product, Error>) -> Void)?) {
        networkProvider.mock(
            CatalogRequest.detailInfo(id)
        ) { (result: Result<DataResponse<ProductResponse>, Error>) in
            switch result {
            case .success:
                completion?(result.map(\.data.product))
            case let .failure(error):
                completion?(Result.failure(error))
            }
        }
    }

    // MARK: Private

    private let networkProvider: NetworkProvider

    private let dataService: DataService
}
