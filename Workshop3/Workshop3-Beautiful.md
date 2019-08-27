
Workshop 3 - Beautiful

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
