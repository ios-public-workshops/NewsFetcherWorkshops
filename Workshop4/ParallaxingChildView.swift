import UIKit

protocol ParallaxingChildView: UIView {
    /// Magnitude of possible parallax values for child:
    var childValueRange: CGFloat { get }
    
    /// Minimum value for child parallax (ie child contents appears to be pulled back from center)
    var minimumChildValue: CGFloat { get }

    /// Maximum value for child parallax (ie child contents appears to be pushed away from center)
    var maximumChildValue: CGFloat { get }
    
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
    var minimumChildValue: CGFloat {
        return -0.5 * childValueRange
    }
    
    var maximumChildValue: CGFloat {
        return 0.5 * childValueRange
    }
    
    func childValue(normalizedValue: CGFloat) -> CGFloat {
        // When normalizedValue == 0.0, childValue = minimumChildValue
        // When normalizedValue == 1.0, childValue = maximumChildValue
        return minimumChildValue + (normalizedValue * childValueRange)
    }
}
