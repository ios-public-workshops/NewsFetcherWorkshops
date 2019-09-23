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
    @IBOutlet weak var imageContainer: UIView! {
        didSet {
            imageContainer.layer.cornerRadius = 12.0
            imageContainer.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var articleImage: UIImageView!
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


extension ArticleCell: ParallaxingForegroundView {
    var foregroundValueRange: CGFloat {
        // Range of values from minimum parallax to maximum parallax
        // If we choose 100.0:
        //  - at minimum parallax, image will be 50.0 points higher than normal
        //  - at maximum parallax, image will be 50.0 points lower than normal
        return 100.0
    }
    
    func applyParallax(normalizedValue: CGFloat) {
        let parallaxOffset = foregroundValue(normalizedValue: normalizedValue)
        // We need a way to move image up and down by parallaxOffset
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
