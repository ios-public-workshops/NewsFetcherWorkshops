import UIKit

protocol ParallaxingBackgroundView: UIView {
    
    /// Find the range of possible values for the background, given a particular foreground
    ///
    /// - Parameter foreground: Foreground that is subview of this background view
    /// - Returns: Range of values within background view, in background's reference frame
    func backgroundValueRange(given foreground: ParallaxingForegroundView) -> CGFloat

    /// Find the foreground's current offset within the background's range, and normalized between 0.0 & 1.0
    ///
    /// - Parameter foreground: Foreground that is subview of this background view
    /// - Returns: Normalized value of foreground's offset within background view, in background's reference frame
    func normalizedForegroundOffset(_ foreground: ParallaxingForegroundView) -> CGFloat
    
    /// Update parallax effect on foreground view
    ///
    /// - Parameter foreground: Foreground that is subview of this background view
    func updateParallax(for foreground: ParallaxingForegroundView)
}

extension ParallaxingBackgroundView {
    func updateParallax(for foreground: ParallaxingForegroundView) {
        foreground.applyParallax(normalizedValue: normalizedForegroundOffset(foreground))
    }
}
