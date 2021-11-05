//
//  OrderService.swift
//  SchoolStore
//
//  Created by a1 on 02.11.2021.
//

import Foundation

// MARK: - OrderService

protocol OrderService: AnyObject {
    func createOrder(quantity: String, house: String, apartment: String, etd: String, productId: String, size: String, completion: ((Result<Void, Error>) -> Void)?)
}

// MARK: - OrderServiceImpl

final class OrderServiceImpl: OrderService {
    func createOrder(
        quantity: String,
        house: String,
        apartment: String,
        etd: String,
        productId: String,
        size: String,
        completion: ((Result<Void, Error>) -> Void)?
    ){
        networkProvider.mock(
            OrdersRequest.arrangeOrder(productId: productId, size: size, quantity: quantity, house: house, apartment: apartment, etd: etd),
                             completion: {(result: Result<SentOrder, Error>) in
            switch result {
            case .success:
                print("success")
                completion?(Result.success(()))
            case let .failure(error):
                print("fail")
                completion?(Result.failure(error))
            }
        })
    }
    
    // MARK: Lifecycle
    
    init(networkProvider: NetworkProvider, dataService: DataService) {
        self.networkProvider = networkProvider
        self.dataService = dataService
    }
    
    // MARK: Internal
    
    typealias SentOrder = DataResponse<CreateOrder>
    
    
    // MARK: Private
    
    private let networkProvider: NetworkProvider

    private let dataService: DataService
}
