// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import UIKit

enum VCFactory {
    static func buildAuthVC() -> UIViewController? {
        let vc = StoryboardScene.Auth.initialScene.instantiate()
        let authService = CoreFactory.buildAuthService()
        vc.setup(with: authService)
        return vc
    }

    static func buildTabBarVC() -> UIViewController? {
        StoryboardScene.TabBar.initialScene.instantiate()
    }
    
    static func buildProfileVC() -> UIViewController? {
        let vc = StoryboardScene.Profile.initialScene.instantiate()
        let profileService = CoreFactory.buildProfileService()
        vc.setup(with: profileService)
        return vc
    }
    
    static func buildHistoryVC() -> UIViewController? {
        let vc = StoryboardScene.History.initialScene.instantiate()
        let historyService = CoreFactory.buildHistoryService()
        vc.setup(with: historyService)
        return vc
    }
    
    static func buildCatalogVC() -> UIViewController? {
        let vc = StoryboardScene.Catalog.initialScene.instantiate()
        let catalogService = CoreFactory.buildCatalogService()
        vc.setup(with: catalogService)
        return vc
    }
    
    
    
}
