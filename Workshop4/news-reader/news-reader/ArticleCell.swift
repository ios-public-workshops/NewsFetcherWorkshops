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
    @IBOutlet weak var imageCenterConstraint: NSLayoutConstraint!
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
        imageCenterConstraint.constant = 0
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
        imageDownloadTask = ImageDownloader().downloadImage(url: url) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.articleImage.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ArticleCell: ParallaxingChildView {
    var minimumChildValue: CGFloat {
        return -25.0
    }
    
    var maximumChildValue: CGFloat {
        return 25.0
    }

    func applyParallax(normalizedValue: CGFloat) {
        imageCenterConstraint.constant = childValue(normalizedValue: normalizedValue)
    }
    
    func childValue(normalizedValue: CGFloat) -> CGFloat {
        return maximumChildValue - (normalizedValue * childValueRange)
    }
}
