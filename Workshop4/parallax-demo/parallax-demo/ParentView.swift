//
//  ParentView.swift
//  parallax-demo
//
//  Created by Kent Humphries on 19/9/19.
//  Copyright © 2019 HumpBot. All rights reserved.
//

import Foundation
import UIKit

class ParentView: UIScrollView {
    
}

extension ParentView: ParallaxingParentView {
    var minimumParentValue: CGFloat {
        return 0.0
    }
    
    var maximumParentValue: CGFloat {
        return frame.size.height
    }
    
    func normalizedChildValue(_ child: ParallaxingChildView) -> CGFloat {
        let childCenterY = relativeChildCenterY(child)
        let range = (maximumParentValue - minimumParentValue) + child.frame.size.height
        
        let normalized = childCenterY / range
        return normalized
    }
    
    func relativeChildCenterY(_ child: ParallaxingChildView) -> CGFloat {
        let childCenterY = child.center.y
        let relativeChildCenterY = childCenterY - contentOffset.y +  (0.5 * child.frame.size.height)
        return relativeChildCenterY
    }
    
    func updateParallax(for child: ParallaxingChildView) {
        child.applyParallax(normalizedValue: normalizedChildValue(child))
    }
}
