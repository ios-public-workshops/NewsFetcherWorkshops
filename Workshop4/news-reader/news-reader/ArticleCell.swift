//
//  ArticleCell.swift
//  news-reader
//
//  Created by Kent Humphries on 9/9/19.
//  Copyright © 2019 Codebar. All rights reserved.
//

import UIKit
import Kingfisher

class ArticleCell: UITableViewCell {
    
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleImage: UIImageView! {
        didSet {
            articleImage.layer.cornerRadius = 12.0
            articleImage.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var articleDescription: UILabel!
    
    override var textLabel: UILabel? {
        return articleTitle
    }
    
    override var detailTextLabel: UILabel? {
        return articleDescription
    }
    
    var imageDownloadTask: URLSessionDataTask?
    
    override func prepareForReuse() {
        backgroundColor = .white
        articleImage.image = UIImage(named: "placeholder-image")
        imageDownloadTask?.cancel()
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

extension ArticleCell {
    func loadImage(at url: URL) {
        
        // Show an indicator while image is being fetched
        articleImage.kf.indicatorType = .activity
        articleImage.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholder-image"),
            options: [
                // Fade image in so it's delightful!
                .transition(.fade(1)),
                // Enable line below to disable image caching
                .cacheMemoryOnly, .memoryCacheExpiration(.expired)
            ])
        { result in
            if case let .failure(error) = result  {
                print(error)
            }
        }
    }
}
