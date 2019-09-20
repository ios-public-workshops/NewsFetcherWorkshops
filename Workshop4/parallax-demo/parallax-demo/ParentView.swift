//
//  ParentView.swift
//  parallax-demo
//
//  Created by Kent Humphries on 19/9/19.
//  Copyright © 2019 HumpBot. All rights reserved.
//

import Foundation
import UIKit

class ParentView: UIScrollView {}

///
/// - For the ParentView, range of possible values should be y coordinates:
///   - **from** when bottom of child is equal to top of parent (this position should be normalized to 0.0)
///   - **to** when top of child is equal to bottom of parent   (this position should be normalized to 1.0)
/// - This gives a range equal to height of PARENT + height of CHILD
/// ```
/// Visual Example:
///
///    MINIMUM (0.0)                            MAXIMUM (1.0)
///
/// +---CHILD TOP----+\
/// |                | |
/// |     CHILD      |  > NOT VISIBLE (OFFSCREEN)
/// |                | /
/// +--CHILD BOTTOM--+ ---  TOP OF PARENT --- +----------------+
/// |                |                        |                |
/// |                |                        |                |
/// |                |                        |                |
/// |     PARENT     |                        |     PARENT     |
/// |                |                        |                |
/// |                |                        |                |
/// |                |                        |                |
/// +----------------+ -- BOTTOM OF PARENT -- +---CHILD TOP----+
///                                          /|                |
///                NOT VISIBLE (OFFSCREEN) <  |     CHILD      |
///                                         | |                |
///                                          \+--CHILD BOTTOM--+
/// ```
extension ParentView: ParallaxingParentView {
    func parentValueRange(given child: ParallaxingChildView) -> CGFloat {
        // Range is all the valid values for visibleOffsetOfButtom of child:
        // - from 0.0 when child is perfectly above parent
        // - to parent.height + child.height when child is perfectly below parent
        return frame.size.height + child.frame.size.height
    }
    
    func normalizedChildOffset(_ child: ParallaxingChildView) -> CGFloat {
        let offset = visibleOffsetOfButtom(for: child)
        let range = parentValueRange(given: child)
        let normalized = offset / range
        return normalized
    }
    
    func visibleOffsetOfButtom(for child: ParallaxingChildView) -> CGFloat {
        // First get the child's bottom within the scroll views. This is relative to the entire scroll view.
        // ie if there is an item that is 140 points tall above the child, bottomY = 140 + child.frame.size.height
        let bottomY = child.frame.origin.y + child.frame.size.height
        // Now determine how far this is relative to the visible top of the scroll view.
        // ie    if bottomY = 160, and scrollView is scrolled to position 100,
        //   visibleBottomY = 60 (bottom of child is 60 points below visible top of scroll view)
        let visibleBottomY = bottomY - contentOffset.y
        return visibleBottomY
    }
}
