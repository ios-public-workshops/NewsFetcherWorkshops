Workshop 4 - Delight & Interaction

- Customise navigation bar
  - Get a custom image from design team
  - Tint the navigation bar to a color of your choice
  - Add a right hand item that is information button which when tapped shows the "data from newsapi.org" in a delightful way :awesome:

- Add parallax effect to images
   - Create method on ArticleCell to arbitrarily offset the image vertically within a container view
   - Create a function that gets the proportion scrolled of a cell in ViewController
   - Add UIScrollViewDelegate to update ArticleCell offset on UIScrollViewDelegate didScroll
   - Add a dampening so the image scrolls slower than the scroll view

 - Implement pull to refresh?

<!--
- Add an alpha animation to cells
 - On cellWillAppear - animate something in?
 - Make a UIEffectView blur disappear without animation
 - Add an animation so user can appreciate what is going on
  - Tweak the animation duration until it feels right
- Remind of cell reuse to clean up
-->

<!-- - Add a 'read' state to each article
 - When user taps an article, save that index path
  - Learn about saving state in a UIViewController
 - When viewDidAppear occurs, use alpha animation to show blur EffectView + green check over article image
   - Learn about UIViewController life cycle
   - learn about UIAnimations + alpha levels -->

- Add a filter/search function
  - Nest disclaimer label within a vertical stack view
  - Add a UITextField to stack view (Mention safe areas?!)
    - Explain UITextField delegate
  - As the user types, perform a .filter{} to articles to create a new array filteredArticles
  - Update dataSource to use filteredArticles instead
  - Return key of keyboard dismisses keyboard (does not remove filter)
  - If de-blur animation is annoying while filtering, add a `isFiltering` bool and don't animate when `isFiltering` == true

 <!-- - Add a show more to each article
    - Button in the bottom of cell that says read more.
    - When tap, -->
