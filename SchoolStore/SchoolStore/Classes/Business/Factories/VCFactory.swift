// HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import UIKit

enum VCFactory {
    static func buildAuthVC() -> UIViewController? {
        let vc = StoryboardScene.Auth.initialScene.instantiate()
        let authService = CoreFactory.buildAuthService()
        let snacker = CoreFactory.snacker
        vc.setup(with: authService, snacker)
        return vc
    }

    static func buildTabBarVC() -> UIViewController? {
        let tabBarVC = StoryboardScene.TabBar.initialScene.instantiate()
        tabBarVC.viewControllers?.forEach { vc in
            guard let nvc = vc as? UINavigationController, let rootVC = nvc.viewControllers.first else {
                return
            }
            nvc.navigationBar.prefersLargeTitles = true
            switch rootVC {
            case let vc as ProfileVC:
                vc.dataService = CoreFactory.dataService
            case let vc as HistoryVC:
                vc.historyService = CoreFactory.buildHistoryService()
                vc.snacker = CoreFactory.snacker
            case let vc as CatalogVC:
                vc.catalogService = CoreFactory.buildCatalogService()
                vc.snacker = CoreFactory.snacker
            default:
                break
            }
        }
        return tabBarVC
    }

    static func buildProductVC(with product: Product) -> UIViewController {
        let vc = ProductVC()
        vc.product = product
        return vc
    }
    
    static func buildCheckoutVC(with product: Product) -> UIViewController {
        let vc = CheckoutVC()
        vc.product = product
        return vc
    }
}
