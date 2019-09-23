import UIKit

extension UITableView: ParallaxingBackgroundView {
    
    /// - For the background, range of possible values should be:
    ///   - **min** when bottom of foreground is equal to top of background
    ///   - **max** when top of foreground is equal to bottom of background
    /// - This gives a range = background.height + foreground.height
    ///                      = UITableView.height + ArticleCell.height
    /// ```
    /// Visual Example of ArticleCell as foreground & UITablleView as background:
    ///
    ///    min Parallax                             max Parallax
    ///
    /// +----cell top----+\
    /// |                | |
    /// |  ArticleCell   |  > NOT VISIBLE (OFFSCREEN)
    /// |                | /
    /// +--cell bottom---+ - -top of visible part - - +----------------+
    /// |                |                            |                |
    /// |                |                            |                |
    /// |  Visible part  |                            |  Visible part  |
    /// | of UITableView |                            | of UITableView |
    /// |                |                            |                |
    /// |                |                            |                |
    /// |                |                            |                |
    /// +----------------+ - bottom of visible part - +----cell top----+
    ///                                              /|                |
    ///                    NOT VISIBLE (OFFSCREEN) <  |  ArticleCell   |
    ///                                             | |                |
    ///                                              \+--cell bottom---+
    /// ```
    func backgroundValueRange(given foreground: ParallaxingForegroundView) -> CGFloat {
        return frame.size.height + foreground.frame.size.height
    }
    
    func normalizedForegroundOffset(_ foreground: ParallaxingForegroundView) -> CGFloat {
        // Get the bottom coordinate of the foreground = origin + height
        let bottomY = foreground.frame.origin.y + foreground.frame.size.height
        
        // UITableViews are complex. They're actually one super long list of ArticleCells stacked on top of each other.
        // We want to know the position of the ArticleCell relative to the *visible* part of the UITableView.
        // The contentOffset of the UITableView tells us where the *visible* part currently begins
        let bottomYPosition = bottomY - contentOffset.y
        return bottomYPosition
    }
}
