# Workshop 3 - Beautiful
Today we are going to make our app _beautiful_. Fetching data from the internet is only the first step toward making a successful app. We need to make sure our app is pleasing to look at - that's what we'll be focussing on today by adding images.

### Prerequisites:
- Complete the [workshop 1 tutorial](../Workshop1/Workshop1-Creation.md)
- Complete the [workshop 2 tutorial](../Workshop2/Workshop2-Networking.md)

## 1. Alternating row colors
1. Remember that our cell is defined as a `Prototype Cell` in our `Main.storyboard`. This is the quickest way to add a `UITableViewCell` into a table, however it doesn't provide many customization options.

1. In order to customize our cell, let's pull it out of the storyboard into it's own file. First, create a new `Cocoa Touch Class`:

    <img src="images/create_cocoaTouchClass.png" title="Create a new Cocoa Touch Class" alt="Create a new Cocoa Touch Class">

1. Name the file `ArticleCell`, make it a Subclass of `UITableViewCell` and check the box to `Also create XIB file`.

1. Now we have two new files added to our project - `ArticleCell.swift` & `ArticleCell.xib`

    <img src="images/new_cell_files.png" title="ArticleCell.swift & ArticleCell.xib" alt="ArticleCell.swift & ArticleCell.xib">

1. All we need to do is set the `Identifier` & `Style` inside `ArticleCell.xib` to match the prototype cell in `Main.storyboard`.

    <img src="images/new_cell_properties.png" title="ArticleCell.xib setting Identifier & Style" alt="ArticleCell.xib setting Identifier & Style">

1. Now we can fire up the app and see our custom cell!

    <img src="images/new_cell_not_registered.png" title="ArticleCell is not registered" alt="ArticleCell is not registered">

1. Oops - we forget to register our new `ArticleCell` inside `ViewController`. Let's do that:

    ```swift
    override func viewDidLoad() {
        super.viewDidLoad()

        ...

        // Configure the TableView to use our class as the Data Source
        tableView.dataSource = self
        // Register the cell we wish to use so that the system can reuse cells for memory efficiency
        tableView.register(ArticleCell.self, forCellReuseIdentifier: "ArticleCell")
        ...
    }
    ```

1. Fire up the app and it should look same as before. It's all working perfectly, right? Not quite. Our article descriptions are missing. Why? We set the style of the cell to be `subtitle`, and we're still setting `detailTextLabel` in our `UITableViewDataSource` method... :think:

    <img src="images/new_cell_no_subitle.png" title="ArticleCell is missing description" alt="ArticleCell is missing description">

1. This problem is tricky to debug - Apple doesn't give us any hints this time. The issue is that we're only registering the `ArticleCell` _class_ in `ViewController`. Essentially, `ViewController` knows about `ArticleCell.swift`, but doesn't realise that `ArticleCell.xib` exists! :sweat-smile:

1.  `ArticleCell.xib` is the place where we set the cell style to `subtitle`, so we need to ensure that `ViewController` knows about the `xib` file too. In order to do this, we register a `nib` rather than a `class`:

    ```swift
    override func viewDidLoad() {
        super.viewDidLoad()

        ...

        // Configure the TableView to use our class as the Data Source
        tableView.dataSource = self
        // Register the cell we wish to use so that the system can reuse cells for memory efficiency
        // Since we're using a custom cell with custom .xib file, we need to register the cell with a nib
        let cellNib = UINib(nibName: "ArticleCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "ArticleCell")
        ...
    }
    ```
    
1. OK - what is the connection between `ArticleCell.xib` and `UINib(nibName: "ArticleCell", bundle: nil)`?!?
 - NIB stands for `NeXtStep Interface Builder`
 - XIB stands for `XML Interface Builder`
 - In the same way that `.swift` files are compiled into machine code to run on a device, `.xib` files are compiled into `nibs` and _bundled_ alongside the machine code
 - When we pass a `nil` bundle, iOS knows that we want to fetch a nib from the app's default (aka `main`) bundle

1. Enough theory! Fire up the app, make sure it's working, and then let's get back to the fun stuff.

    <img src="images/new_cell_basic.png" title="ArticleCell is working" alt="ArticleCell is working">

1. Let's try alternating the cell backgrounds so we can more easily tell them apart. We do this by setting the `backgroundColor` depending on `indexPath.row`:


    ```swift
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        ...        
        cell.detailTextLabel?.text = article.description
        cell.detailTextLabel?.numberOfLines = 0
        
        // Divide the row's index by 2 and if there's a remainder of 1, we have an odd index
        if indexPath.row % 2 == 1 {
            cell.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        }
        
        return cell
    }
    ```

1. Run the app and scroll up and down. What is going on _now_?

    <img src="images/alternating_color_no_prepare_for_reuse.png" title="Second cell has light gray background" alt="Second cell has light gray background">

1. This issue appears because of cell reuse. Recall in `workshop 1` we explained how `UITableViewCells` are reused for memory efficiency. In this case, our light gray cell is being reused, so we need to ensure that we reset it each time it's reused. Luckily, there's a method for that in `UITableViewCell`:

    ```swift
    class ArticleCell: UITableViewCell {
        ...
        override func prepareForReuse() {
            self.backgroundColor = .white
        }
    }
    ```

1. Now run the app and marvel at our custom `ArticleCell` with alternating background colors. :tada:

## 2. Adding an Image

1. Let's start by adding an image to each cell. Eventually we'll fetch an appropriate image from `newsapi.org`, but for now a static image will do.

1. Download [placeholder-image.png](./placeholder-image.pdf) to your computer. We use this format as pdfs can be scaled without losing quality. Note that iOS doesn't actually render these images as pdf, Xcode converts them to png first.

1. Now open the `Assets.xcassets` folder in Xcode and drop the image into the large gray area:

    ![Animation showing an image being dragged from downloads and dropped into Assets.xcassets on Xcode](images/add_static_image.gif)


- Add image
  - Adding a static UIImageView to our custom cell using autolayout
    - Show the placeholder image for each cell (vertical alignment)
    - Nest image + labels inside stack views
    - Add a constraint to image to make it look consistent in each cell, irrespective of label number of lines
    - Intentionally make mistakes to show different features of UIImageView

- Download an Image
    - need to parse image url from api by updating struct
   - We write an extension of UIImageView & explain how extensions work
   - We explain how our image downloader works at a high level
   - We fire up the app -> mention the limitations of this simple implementation
    - race conditions/cancellation
    - loading state
    - failure state

- Introduce COCOAPODS as a way to add dependencies
  - Talk about workspaces
  - Switch to using a cocoapod to download image (Kingfisher?)
