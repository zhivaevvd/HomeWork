// HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ScrollableView

public protocol ScrollableView: UIView {
    var innerScrollView: UIScrollView? { get }
}

// MARK: - UIView + ScrollableView

extension UIView: ScrollableView {}

public extension ScrollableView where Self: UIView {
    var innerScrollView: UIScrollView? { subviews.first as? UIScrollView }
}
