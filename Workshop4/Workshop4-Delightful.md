# Workshop 4 - Delight

Last workshop we focussed on making our app more visually appealing with images. Today we are going to polish things up and add some touches of _delight_. When we talk about _delight_, we mean nice flourishes or interactions that just _feel_ nice to our users. When you scroll a lot of text on an iPhone and you reach the end, it bounces back into place. This is a great example of _delight_.

### Prerequisites:
- Complete the [workshop 1 tutorial](../Workshop1/Workshop1-Creation.md)
- Complete the [workshop 2 tutorial](../Workshop2/Workshop2-Networking.md)
- Complete the [workshop 3 tutorial](../Workshop3/Workshop3-Beautiful.md)

## 1. Better image downloading
1. Let's start by improving our image downloading. Last workshop we used the file `ImageDownloading.swift` to download our images. We used a placeholder image that shows while an image is downloading, or when an image fails to load:

    <img src="images/simulator_image_placeholders.png" height="600"  title="Cells with placeholder image" alt="Cells with placeholder image">

1. This doesn't give the user much feedback on what is happening. They don't know whether the image is currently downloaded, or whether the image failed to load for some reason. Also, we redownload the image every time the user scrolls. Rather than add a whole lot of functionality to `ImageDownloading.swift`, let's consider using a `Pod` instead.

1. [CocoaPods](https://www.cocoapods.org) is an industry standard package manager used in the iOS development community. A package manager allows us to quickly add 3rd party (not written by Apple) packages or libraries to our app. CocoaPods refers these libraries as `Pods`.
    - In 2019 Apple released its own [Swift Package Manager](https://github.com/apple/swift-package-manager). Apple's  Swift Package Manager is owned by Apple which is an important consideration for iOS. Apple can and does make changes that break 3rd party tools, but CocoaPods is well supported and still has a larger library of available packages, so we will use it for this example.

1. We're going to add the Pod `Kingfisher` to our app.

- Add Cocoa Pods pod for easier image downloading 

- Customise navigation bar
  - Get a custom image from design team
  - Tint the navigation bar to a color of your choice
  - Add a right hand item that is information button which when tapped shows the "data from newsapi.org" in a delightful way :awesome:
      - Transition to an InfoViewController that just shows static text?
          - newsapi.org
          - Cocoapod used
          - Information about the author :)

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

<!-- 
- Add a filter/search function
  - Nest disclaimer label within a vertical stack view
  - Add a UITextField to stack view (Mention safe areas?!)
    - Explain UITextField delegate
  - As the user types, perform a .filter{} to articles to create a new array filteredArticles
  - Update dataSource to use filteredArticles instead
  - Return key of keyboard dismisses keyboard (does not remove filter)
  - If de-blur animation is annoying while filtering, add a `isFiltering` bool and don't animate when `isFiltering` == true
-->

 <!-- - Add a show more to each article
    - Button in the bottom of cell that says read more.
    - When tap, -->
