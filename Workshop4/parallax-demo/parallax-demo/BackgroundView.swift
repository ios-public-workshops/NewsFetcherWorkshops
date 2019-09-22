//
//  BackgroundView.swift
//  parallax-demo
//
//  Created by Kent Humphries on 19/9/19.
//  Copyright © 2019 HumpBot. All rights reserved.
//

import Foundation
import UIKit

class BackgroundView: UIScrollView {}

///
/// - For the BackgroundView (BG), range of possible values should be y coordinates:
///   - **from** when bottom of foreground is equal to top of background (this position should be normalized to 0.0)
///   - **to** when top of foreground is equal to bottom of background   (this position should be normalized to 1.0)
/// - This gives a range equal to height of BACKGROUND + height of FOREGROUND
/// ```
/// Visual Example:
///
///    MINIMUM (0.0)                            MAXIMUM (1.0)
///
/// +-----FG TOP-----+\
/// |                | |
/// |  FOREGROUND    |  > NOT VISIBLE (OFFSCREEN)
/// |                | /
/// +----FG BOTTOM---+ -----  TOP OF BG ----- +----------------+
/// |                |                        |                |
/// |                |                        |                |
/// |                |                        |                |
/// |   BACKGROUND   |                        |   BACKGROUND   |
/// |                |                        |                |
/// |                |                        |                |
/// |                |                        |                |
/// +----------------+ ---- BOTTOM OF BG ---- +-----FG TOP-----+
///                                          /|                |
///                NOT VISIBLE (OFFSCREEN) <  |  FOREGROUND    |
///                                         | |                |
///                                          \+----FG BOTTOM---+
/// ```
extension BackgroundView: ParallaxingBackgroundView {
    func backgroundValueRange(given foreground: ParallaxingForegroundView) -> CGFloat {
        // Range is all the valid values for visibleOffsetOfButtom of foreground:
        // - from 0.0 when foreground is perfectly above background
        // - to background.height + foreground.height when foreground is perfectly below background
        return frame.size.height + foreground.frame.size.height
    }
    
    func normalizedForegroundOffset(_ foreground: ParallaxingForegroundView) -> CGFloat {
        let offset = visibleOffsetOfButtom(for: foreground)
        let range = backgroundValueRange(given: foreground)
        let normalized = offset / range
        return normalized
    }
    
    func visibleOffsetOfButtom(for foreground: ParallaxingForegroundView) -> CGFloat {
        // First get the foreground's bottom within the scroll views. This is relative to the entire scroll view.
        // ie if there is an item that is 140 points tall above the foreground, bottomY = 140 + foreground.frame.size.height
        let bottomY = foreground.frame.origin.y + foreground.frame.size.height
        // Now determine how far this is relative to the visible top of the scroll view.
        // ie    if bottomY = 160, and scrollView is scrolled to position 100,
        //   visibleBottomY = 60 (bottom of foreground is 60 points below visible top of scroll view)
        let visibleBottomY = bottomY - contentOffset.y
        return visibleBottomY
    }
}
