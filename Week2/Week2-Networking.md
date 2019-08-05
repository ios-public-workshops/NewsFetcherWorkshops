# Week 2 - Networking
Today we are going to make our app _really_ talk to the internet! We are going to add networking functionality and retrieve data from the public newsapi.org service.

### Prerequisites:
- Complete the [week 1 tutorial](../Week1/Week1-Creation.md)!

## 1. Downloading real data
1. Register a new API key at [newsapi.org](https://newsapi.org/register/). This key gives us permission to download news articles from the API. <image of newsapi.org form filled out>
1. Part of the conditions of using newsapi.org data is that we have to attribute the website in our app. Let's add a header to our table that shows where we are fetching data from.
1. Go to the `Main.storyboard` file and add a `UILabel` to the `UITableViewFooter` <animation of adding the UILabel>
1. Update the label content to read `Data from newsapi.org`
1. Now let's actually download the data from newsapi.org. Navigate to `NewsFetching.swift`. Remember this was a stubbed file we dropped in to fetch data from "The Internet".
1. Delete the contents of `func getLatestArticles()`
    ```swift
    class NewsFetcher {
        func getLatestArticles(_ completion: @escaping (Result<[NewsItem], NewsFetcherError>) -> Void) {
        }
    }
    ```
1. Even though _we're_ all perfect programmers, unfortunately sometimes things can go wrong. It's best practice in iOS to pass errors up to the highest level. We will now add some possible errors to our code above `func getLatestArticles()`:
    ```swift
    enum NewsFetcherError: Error {
        case someError
        case invalidURL
        case invalidData
        case cannotParseData
    }
    ```
1. Now we will use iOS system functionality to download the real articles. For this we need an `NSURL`, an `NSURLSession` and a `dataTask`
 and instead use an `NSURLSession` `dataTask` to get real articles!
    ```swift
    class NewsFetcher {
        private let session = URLSession.shared

        func getLatestArticles(_ completion: @escaping (Result<[NewsItem], NewsFetcherError>) -> Void) {
            guard let url = URL(string: "https://newsapi.org/v2/top-headlines") else {
                completion(.failure(.invalidURL))
                return
            }

            session.dataTask(with: url) { data, response, error in

            }
        }
    }
    ```
1. Great - we're getting the articles now, but we can't see them! Let's dump the data to make sure that `newsapi.org` is really working. And remember our errors? We're going to use some more of them now!
    ```swift
    func getLatestArticles(_ completion: @escaping (Result<[NewsItem], NewsFetcherError>) -> Void) {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines") else {
            completion(.failure(.invalidURL))
            return
        }

        session.dataTask(with: url) { data, response, error in
            guard error != nil else {
                completion(.failure(.someError))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            dump(data)
        }
    }
    ```
## 2. Showing downloaded dataTask
1. We're able to dump the raw data from `newsapi.org`, but the point of our iOS app is to make it pretty!! :rose: So let's start by converting the response to `NewsItems`:
    ```swift
    func getLatestArticles(_ completion: @escaping (Result<[NewsItem], NewsFetcherError>) -> Void) {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines") else {
            completion(.failure(.invalidURL))
            return
        }

        session.dataTask(with: url) { data, response, error in
            guard error != nil else {
                completion(.failure(.someError))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            do {
                let articles = try JSONDecoder().decode([NewsItem].self, from: data)
                print(articles)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    ```



1. Adds pull to refresh
1. Trigger the network call after pulling to refresh
1. Call the real endpoint (hardcoded) using URLSession and return real data
1. Adjust the TableView to use the newly returned data
1. Introduce the concept of closures and async operations
1. Introduce the concept of URLComponents and how to build URLs safely on iOS
1. Build the URL to call the endpoint for returning articles
1. Adjust Decodable data to include link to article
1. Open content in a safari web view controller
