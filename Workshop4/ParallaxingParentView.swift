import UIKit

protocol ParallaxingParentView: UIView {
    
    /// Find the range of possible values for the parent, given a particular child
    ///
    /// - Parameter child: Child that is subview of this parent view
    /// - Returns: Range of values within parent view, in parent's reference frame
    func parentValueRange(given child: ParallaxingChildView) -> CGFloat

    /// Find the child's current offset within the parent's range, and normalized between 0.0 & 1.0
    ///
    /// - Parameter child: Child that is subview of this parent view
    /// - Returns: Normalized value of child's offset within parent view, in parent's reference frame
    func normalizedChildOffset(_ child: ParallaxingChildView) -> CGFloat
    
    /// Update parallax effect on child view
    ///
    /// - Parameter child: Child that is subview of this parent view
    func updateParallax(for child: ParallaxingChildView)
}

extension ParallaxingParentView {
    func updateParallax(for child: ParallaxingChildView) {
        child.applyParallax(normalizedValue: normalizedChildOffset(child))
    }
}
