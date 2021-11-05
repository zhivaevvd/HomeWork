// HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import UIKit

public protocol BottomSheetStyle {
    var cornerRadius: CGFloat { get }
    var backgroundColor: UIColor { get }
    var arrowSize: CGSize { get }
    var arrowCornerRadius: CGFloat { get }
    var arrowColor: UIColor { get }
    var arrowTopOffset: CGFloat { get }
    var arrowToContent: CGFloat { get }
    var contentMargin: UIEdgeInsets { get }
    var bottomSheetTopOffset: CGFloat { get }
}
