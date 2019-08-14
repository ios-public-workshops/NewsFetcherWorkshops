//
//  ViewController.swift
//  news-reader
//
//  Created by Lucas Lima on 01.07.19.
//  Copyright © 2019 Codebar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var articles = [NewsItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configure the TableView to reuse cells based on an identifier
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ArticleCell")
        
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
                
                // The tell the tableView it should reload its data
                self?.tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath)
        cell.textLabel?.text = articles[indexPath.row].title
        return cell
    }
}
