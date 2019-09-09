//
//  ArticleCell.swift
//  news-reader
//
//  Created by Kent Humphries on 9/9/19.
//  Copyright © 2019 Codebar. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleImage: UIImageView! {
        didSet {
            articleImage.layer.cornerRadius = 12.0
        }
    }
    @IBOutlet weak var articleDescription: UILabel!
    
    override var textLabel: UILabel? {
        return articleTitle
    }
    
    override var detailTextLabel: UILabel? {
        return articleDescription
    }
    
    override func prepareForReuse() {
        self.backgroundColor = .white
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
