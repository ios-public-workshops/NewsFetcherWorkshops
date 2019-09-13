//
//  ViewController.swift
//  news-reader
//
//  Created by Lucas Lima on 01.07.19.
//  Copyright © 2019 Codebar. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var articles = [NewsItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Sets a title the current screen
        title = "News Fetcher"
        
        // Configure the TableView to use our class as the Delegate
        tableView.delegate = self
        // Configure the TableView to use our class as the Data Source
        tableView.dataSource = self
        
        // Create a new instance of NewsFetcher to do our fetching
        let fetcher = NewsFetcher()
        // Ask fetcher to get latest articles
        // This is an asynchronous call
        // Code between { ... } will be executed when the data has been fetched
        // Note: Result is a Swift type that captures either success or failure in a single enum
        fetcher.getLatestArticles { [weak self] (result: Result<[NewsItem], NewsFetcherError>) in
            switch result {
            case .success(let newArticles):
                // If fetching was successful, set the articles variable from ViewController with new articles
                self?.articles = newArticles
                
                // Then tell the tableView it should reload its data
                // Remember to call reloadData() from the main thread
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                // If fetching failed, print the error
                print(error.localizedDescription)
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // This always fetches a cell of type UITableViewCell, even if we are using a custom subclass
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath)
        let article = articles[indexPath.row]
        
        cell.textLabel?.text = article.title
        cell.textLabel?.numberOfLines = 0
        
        cell.detailTextLabel?.text = article.description
        cell.detailTextLabel?.numberOfLines = 0
        
        // Divide the row's index by 2 and if there's a remainder of 1, we have an odd index
        if indexPath.row % 2 == 1 {
            cell.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        }
        
        // We need to ensure that we actually have a cell of type ArticleCell
        guard let articleCell = cell as? ArticleCell else {
            return cell
        }
        
        if let imageUrl = article.urlToImage {
            articleCell.loadImage(at: imageUrl)
        }
        
        return articleCell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get the selected article using the tapped row
        let selectedArticle = articles[indexPath.row]
        
        // Create a new screen for loading Web Content using SFSafariViewController
        let articleViewController = SFSafariViewController(url: selectedArticle.url)
        
        // Present the screen on the Navigation Controller
        navigationController?.present(articleViewController, animated: true, completion: nil)
    }
}
