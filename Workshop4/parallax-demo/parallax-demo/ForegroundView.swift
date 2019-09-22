//
//  ForegroundView.swift
//  parallax-demo
//
//  Created by Kent Humphries on 19/9/19.
//  Copyright © 2019 HumpBot. All rights reserved.
//

import UIKit
import Foundation

class ForegroundView: UIView {
    @IBOutlet weak var circleImageVerticalCenter: NSLayoutConstraint!
    @IBOutlet weak var diagnosticLabel: UILabel!
    
    var pauseParallax: Bool = false
    var parallaxStrength: CGFloat = 1.0
    
    override func awakeFromNib() {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0.5
    }
    
    func updateDiagnostics(normalizedValue: CGFloat) {
        let offsetText = String(format: "offset = %0.1f", circleImageVerticalCenter.constant)
        diagnosticLabel.text = """
                               foreground
                               \(offsetText)
                               """
    }
}

/// - For the ForegroundView (FG), parallax should be on y coordinate:
///   - **when normalizedValue is 0.0** maximum upward parallax should be applied
///   - **when normalizedValue is 0.5** no parallax should be applied
///   - **when normalizedValue is 1.0** maximum downward parallax should be applied
/// ```
/// Visual Example:
///
///              MINIMUM (0.0)                 MAXIMUM (1.0)                   NONE (0.5)
///      (foreground image pulled up       (foreground image pushed down      (no parallax)
///       by 0.5 * foreground.height)         by 0.5 * foreground.height)
///
///             ..................\
///             .      ****      . |
///             .    ********    .  > NOT VISIBLE                           ..................
///             .  ************  . /                                        .      ****      . > NOT VISIBLE
/// TOP OF ---> +----------------+            +----------------+            +----------------+
///   FG        |  ************  |            |      ****      |            |  ************  |
///             |----FG CENTER---| -  -  -  - |----FG CENTER---| -  -  -  - |----FG CENTER---|
/// BOTTOM OF   |      ****      |            |  ************  |            |  ************  |
///    FG   --> +----------------+            +----------------+            +----------------+
///                                          /.  ************  .            .      ****      . > NOT VISIBLE
///                            NOT VISIBLE <  .    ********    .            ..................
///                                         | .      ****      .
///                                          \..................
/// ```
extension ForegroundView: ParallaxingForegroundView {
    var foregroundValueRange: CGFloat {
        // Min parallax pulls image up by -0.5 * ForegroundView height     \
        //                                                                   --> Add magnitudes together = ForegroundView height
        // Max parallax pushes image down by +0.5 * ForegroundView height  /
        let range = frame.size.height
        return range * parallaxStrength // Strength allows user to turn up/down parallax effect
    }
    
    func applyParallax(normalizedValue: CGFloat) {
        guard pauseParallax == false else {
            return
        }
        circleImageVerticalCenter.constant = foregroundValue(normalizedValue: normalizedValue)
        
        updateDiagnostics(normalizedValue: normalizedValue)
    }
}

