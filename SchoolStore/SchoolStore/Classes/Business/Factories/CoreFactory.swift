// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

enum CoreFactory {
    static let requestBuilder: RequestBuilder = RequestBuilderImpl(dataService: Self.dataService)

    static let networkProvider: NetworkProvider = NetworkProviderImpl(requestBuilder: requestBuilder)

    static let dataService: DataService = DataServiceImpl()

    static func buildAuthService() -> AuthService {
        AuthServiceImpl(networkProvider: Self.networkProvider, dataService: Self.dataService)
    }
    
    static func buildHistoryService() -> HistoryService {
        HistoryServiceImpl()
    }
    
    static func buildCatalogService() -> CatalogService {
        CatalogServiceIml()
    }
    
    static func buildProfileService() -> ProfileService {
        ProfileServiceIml()
    }
}
