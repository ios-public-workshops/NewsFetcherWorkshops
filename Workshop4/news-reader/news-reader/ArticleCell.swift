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

extension ArticleCell: ParallaxingView {
    struct ParallaxConstants {
        static let min: CGFloat = -25
        static let max: CGFloat = 25
        static var range: CGFloat {
            return max - min
        }
    }

    func applyParallax(normalizedValue: CGFloat) {
        let parallaxOffset = ParallaxConstants.max - (normalizedValue * ParallaxConstants.range)
        imageCenterConstraint.constant = parallaxOffset
    }
}
