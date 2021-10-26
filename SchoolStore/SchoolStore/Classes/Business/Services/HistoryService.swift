//
//  HistoryService.swift
//  SchoolStore
//
//  Created by a1 on 21.10.2021.
//

import Foundation

protocol HistoryService: AnyObject {
    func getHistoryItems(with offset: Int, limit: Int, completion: ((Result<[Order], Error>) -> Void)?)
}

final class HistoryServiceImpl: HistoryService {
    func getHistoryItems(with offset: Int, limit: Int, completion: ((Result<[Order], Error>) -> Void)?) {
        networkProvider.mock(
            OrdersRequest.listOfOrders(offset: offset, limit: limit)
        ) { (result: Result<DataResponse<OrderResponse>, Error>) in
            switch result {
            case .success:
                //completion?(result.map(\.data.orders))
                completion?(result.map({ obj in obj.data.orders }))
            case let .failure(error):
                completion?(Result.failure(error))
            }
        }
    }
    
    
    
    init(networkProvider: NetworkProvider, dataService: DataService) {
        self.networkProvider = networkProvider
        self.dataService = dataService
    }
    
    
    private let networkProvider: NetworkProvider

    private let dataService: DataService
}
