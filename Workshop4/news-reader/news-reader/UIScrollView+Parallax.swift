//
//  UIScrollView+Parallax.swift
//  news-reader
//
//  Created by Kent Humphries on 17/9/19.
//  Copyright © 2019 Codebar. All rights reserved.
//

import UIKit

protocol ParallaxingView: UIView {
    /// Apply an effect so that view appears to move in parallax with respect to other content
    ///
    /// - Parameter normalizedValue: Value between 0.0 to 1.0. Where 0.0 means minimum parallax effect. 1.0 means maximum parallax effect.
    func applyParallax(normalizedValue: CGFloat)
}

extension UIScrollView {
    var minimumVisibleY: CGFloat {
        return 0.0
    }
    
    var maximumVisibleY: CGFloat {
        return frame.size.height
    }
    
    var currentOffsetY: CGFloat {
        return contentOffset.y
    }
    
    func visibleOffsetY(for view: UIView) -> CGFloat {
        let viewPosition = view.frame.origin.y
        let relativeViewPosition = viewPosition - currentOffsetY
        return relativeViewPosition
    }
    
    func applyParallax(to parallaxView: ParallaxingView) {
        let relativePosition = visibleOffsetY(for: parallaxView)
        // Calculate value as a percentage between min & max (0.0 == min, 1.0 == max)
        let normalizedPosition = relativePosition.normalized(betweenMin: minimumVisibleY, max: maximumVisibleY)
        parallaxView.applyParallax(normalizedValue: normalizedPosition)
    }
}

extension CGFloat {
    func normalized(betweenMin min: CGFloat, max: CGFloat) -> CGFloat {
        guard self > min else {
            return min
        }
        
        guard self < max else {
            return max
        }
        
        let range = max - min
        let normalizedValue = (self - min) / range
        return normalizedValue
    }
}
