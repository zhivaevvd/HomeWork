// HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

protocol UILoadable: AnyObject {
    func startLoading(with parameters: LoaderParameters)
    func stopLoadingProgress()
}
