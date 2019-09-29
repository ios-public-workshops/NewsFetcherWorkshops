import UIKit

protocol ParallaxingForegroundView: UIView {
    /// Magnitude of possible parallax values for foreground:
    var foregroundValueRange: CGFloat { get }
    
    /// Minimum value for foreground parallax (ie foreground contents appears to be pulled back from center)
    var minimumForegroundValue: CGFloat { get }

    /// Maximum value for foreground parallax (ie foreground contents appears to be pushed away from center)
    var maximumForegroundValue: CGFloat { get }
    
    /// The parallax effect to apply to the foreground between `minimumForegroundValue` and `maximumForegroundValue`
    ///
    /// - Returns: Parallax effect to apply to the foreground between `minimumForegroundValue` and `maximumForegroundValue`
    func foregroundValue(normalizedValue: CGFloat) -> CGFloat
    
    /// Apply an effect so that view appears to move in parallax with respect to a ParallaxingBackgroundView
    ///
    /// - Parameter normalizedValue: Value between 0.0 to 1.0. Where 0.0 means minimum parallax effect. 1.0 means maximum parallax effect.
    func applyParallax(normalizedValue: CGFloat)
}

extension ParallaxingForegroundView {
    var minimumForegroundValue: CGFloat {
        return -0.5 * foregroundValueRange
    }
    
    var maximumForegroundValue: CGFloat {
        return 0.5 * foregroundValueRange
    }
    
    func foregroundValue(normalizedValue: CGFloat) -> CGFloat {
        // When normalizedValue == 0.0, foregroundValue = minimumForegroundValue
        // When normalizedValue == 1.0, foregroundValue = maximumForegroundValue
        return minimumForegroundValue + (normalizedValue * foregroundValueRange)
    }
}
