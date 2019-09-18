import UIKit

protocol ParallaxingParentView: UIView {
    var minimumParentValue: CGFloat { get }
    var maximumParentValue: CGFloat { get }

    /// Find the child's offset value in the parent's reference frame, and normalized between 0.0 & 1.0
    ///
    /// - Parameter child: Child that is subview of this parent view
    /// - Returns: Normalized value of child's offset within parent view, in parent's reference frame
    func normalizedChildValue(_ child: ParallaxingChildView) -> CGFloat
    
    /// Update parallax effect on child view
    ///
    /// - Parameter child: Child that is subview of this parent view
    func updateParallax(for child: ParallaxingChildView)
}

extension CGFloat {
    /// Given a `min` and a `max`, create a normalized value between [0.0, 1.0] where 0.0 corresponds to `min` and 1.0 corresponds to `max`
    ///
    /// - Note: If this CGFloat is less than `min`, 0.0 will be returned. If this CGFloat is greate than `max`, 1.0 will be returned
    ///
    /// - Parameters:
    ///   - min: Minimum value
    ///   - max: Maximum value
    /// - Returns: Normalizsation of this CGFloat where 0.0 corresponds to `min` and 1.0 corresponds to `max`
    func normalized(betweenMin min: CGFloat, max: CGFloat) -> CGFloat {
        guard self > min else {
            return 0.0
        }
        
        guard self < max else {
            return 1.0
        }
        
        let range = max - min
        return (self - min) / range
    }
}
