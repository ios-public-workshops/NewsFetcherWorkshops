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
}

extension ChildView: ParallaxingChildView {
    var minimumChildValue: CGFloat {
        return -parallaxStrength * frame.size.height
    }
    
    var maximumChildValue: CGFloat {
        return parallaxStrength * frame.size.height
    }
    
    func applyParallax(normalizedValue: CGFloat) {
        guard pauseParallax == false else {
            return
        }
        
        circleImageVerticalCenter.constant = childValue(normalizedValue: normalizedValue)
        updateDiagnostics(normalizedValue: normalizedValue)
    }

    func updateDiagnostics(normalizedValue: CGFloat) {
        let normalizedText = String(format: "Normalized Parallax = %0.4f", normalizedValue)
        let offsetText = String(format: "circleOffsetFromCenter = %0.2f", circleImageVerticalCenter.constant)
        diagnosticLabel.text = """
                                  ParallaxingChildView
                                  \(normalizedText)
                                  \(offsetText)
                               """
    }
}

