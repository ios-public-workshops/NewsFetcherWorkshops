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
}

extension ChildView: ParallaxingChildView {
    var minimumChildValue: CGFloat {
        return -parallaxStrength * 0.5 * frame.size.height
    }
    
    var maximumChildValue: CGFloat {
        return parallaxStrength * 0.5 * frame.size.height
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

