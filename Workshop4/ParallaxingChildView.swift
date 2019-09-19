import UIKit

protocol ParallaxingChildView: UIView {
    var minimumChildValue: CGFloat { get }
    var maximumChildValue: CGFloat { get }
    var childValueRange: CGFloat { get }
    
    /// The parallax effect to apply to the child between `minimumChildValue` and `maximumChildValue`
    ///
    /// - Returns: Parallax effect to apply to the child between `minimumChildValue` and `maximumChildValue`
    func childValue(normalizedValue: CGFloat) -> CGFloat
    
    /// Apply an effect so that view appears to move in parallax with respect to a ParallaxingParentView
    ///
    /// - Parameter normalizedValue: Value between 0.0 to 1.0. Where 0.0 means minimum parallax effect. 1.0 means maximum parallax effect.
    func applyParallax(normalizedValue: CGFloat)
}

extension ParallaxingChildView {
    var childValueRange: CGFloat {
        return maximumChildValue - minimumChildValue
    }
    
    func childValue(normalizedValue: CGFloat) -> CGFloat {
        return minimumChildValue + (normalizedValue * childValueRange)
    }
}
