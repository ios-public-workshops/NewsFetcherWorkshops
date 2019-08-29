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

1. The first thing we should do is set the `Identifier` & `Style` inside `ArticleCell.xib` to match the prototype cell in `Main.storyboard`.

    <img src="images/new_cell_properties.png" title="ArticleCell.xib setting Identifier & Style" alt="ArticleCell.xib setting Identifier & Style">

1. Now we can delete the prototype cell from `Main.storyboard` and fire up the app!

    <img src="images/new_cell_not_registered.png" title="ArticleCell is not registered" alt="ArticleCell is not registered">

1. Oops - we forget to register our new `ArticleCell` inside `ViewController`. Let's do that:

    ```swift
    override func viewDidLoad() {
        super.viewDidLoad()

        ...

        // Configure the TableView to use our class as the Data Source
        tableView.dataSource = self
        tableView.register(ArticleCell.self, forCellReuseIdentifier: "ArticleCell")
        ...
    }
    ```

1. Fire up the app and it should look same as before. Now let's get to the fun part. Let's try alternating the cell backgrounds so we can more easily tell them apart.

THIS DOES NOT WORK YET

1.

Add details that make the app beautiful:

- Let's pull out our cell and make it it's own UITableViewCell

- alternating table view cell backgrounds? (teach about transparency too)
  - intentionally fuck it up by only changing background color if index == 0 or index == 1
  - Then add prepareForReuse - show that's fixed
  - Now do alternating color for every cell (ie not index == 0/1)

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
