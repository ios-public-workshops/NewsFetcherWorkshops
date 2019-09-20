//
//  ChildView.swift
//  parallax-demo
//
//  Created by Kent Humphries on 19/9/19.
//  Copyright © 2019 HumpBot. All rights reserved.
//

import UIKit
import Foundation

class ChildView: UIView {
    @IBOutlet weak var circleImageVerticalCenter: NSLayoutConstraint!
    @IBOutlet weak var diagnosticLabel: UILabel!
    
    var pauseParallax: Bool = false
    var parallaxStrength: CGFloat = 1.0
    
    override func awakeFromNib() {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0.5
    }
    
    func updateDiagnostics(normalizedValue: CGFloat) {
        let normalizedText = String(format: "Normalized Parallax = %0.4f", normalizedValue)
        let strengthText = String(format: "Parallax Multiplier = %0.2f", parallaxStrength)
        let offsetText = String(format: "circleOffsetFromCenter = %0.2f", circleImageVerticalCenter.constant)
        diagnosticLabel.text = """
                                ParallaxingChildView
                                \(normalizedText)
                                \(strengthText)
                                \(offsetText)
                               """
    }
}

/// - For the ChildView, parallax should be on y coordinate:
///   - **when normalizedValue is 0.0** maximum upward parallax should be applied
///   - **when normalizedValue is 0.5** no parallax should be applied
///   - **when normalizedValue is 1.0** maximum downward parallax should be applied
/// ```
/// Visual Example:
///
///               MINIMUM (0.0)           MAXIMUM (1.0)             NONE (0.5)
///            (child image pulled up  (child image pushed down    (no parallax)
///             by 0.5 * child.height)    by 0.5 * child.height)
///
///             ..................\
///             .      ****      . |
///             .    ********    .  > NOT VISIBLE               ..................
///             .  ************  . /                            .      ****      . > NOT VISIBLE
/// TOP OF ---> +----------------+      +----------------+      +----------------+
///  CHILD      |  ************  |      |      ****      |      |  ************  |
///             |--CHILD CENTER--|      |--CHILD CENTER--|      |--CHILD CENTER--|
/// BOTTOM OF   |      ****      |      |  ************  |      |  ************  |
///   CHILD --> +----------------+      +----------------+      +----------------+
///                                    /.  ************  .      .      ****      . > NOT VISIBLE
///                      NOT VISIBLE <  .    ********    .      ..................
///                                   | .      ****      .
///                                    \..................
/// ```
extension ChildView: ParallaxingChildView {
    var childValueRange: CGFloat {
        // Min parallax pulls image up by -0.5 * ChildView height     \
        //                                                              --> Add magnitudes together = ChildView height
        // Max parallax pushes image down by +0.5 * ChildView height  /
        let range = frame.size.height
        return range * parallaxStrength // Strength allows user to turn up/down parallax effect
    }
    
    func applyParallax(normalizedValue: CGFloat) {
        guard pauseParallax == false else {
            return
        }
        circleImageVerticalCenter.constant = childValue(normalizedValue: normalizedValue)
        
        updateDiagnostics(normalizedValue: normalizedValue)
    }
}

