# Week 2 - Networking
Today we are going to make our app _really_ talk to the internet! We are going to add networking functionality and retrieve data from the public `newsapi.org` service.

### Prerequisites:
- Complete the [week 1 tutorial](../Week1/Week1-Creation.md)!

## 1. Using a real API
1. Register a new API key at [newsapi.org](https://newsapi.org/register/). This key gives us permission to download news articles from the API. <image of newsapi.org form filled out>
1. Part of the conditions of using `newsapi.org` data is that we have to attribute the website in our app. Let's add a header to our table that shows where we are fetching data from.
1. Go to the `Main.storyboard` file and add a `UILabel` to the `UITableViewFooter` <animation of adding the UILabel>
1. Update the label content to read `Data from newsapi.org`
1. Now let's actually download the data from `newsapi.org`. Navigate to `NewsFetching.swift`. Remember this was a stubbed file we dropped in to fetch data from "The Internet".
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
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?q=apple&apiKey=<YOUR_API_KEY_HERE>") else {
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
<Image to show what expected dumped data should look like>

## 2. Showing downloaded titles
1. We're able to dump the raw data from `newsapi.org`, but the point of our iOS app is to make it pretty!! :rose:  
Now we need to make swift objects that match the data sent from the API. They will need to contain:
    - `status`: whether the API call was successful
    - `totalResults`: number of articles returned
    - `Articles`: the content to display
    ```swift
    struct NewsResponse: Decodable {
        let status: String
        let totalResults: Int
        let articles: [NewsItem]
    }

    struct NewsItem: Decodable {
        let title: String
        let description: String
    }
    ```
1. Now we can update `getLatestArticles` to get our articles.

    ```swift
    func getLatestArticles(_ completion: @escaping (Result<[NewsItem], NewsFetcherError>) -> Void) {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?q=apple&apiKey=<YOUR_API_KEY_HERE>") else {
            completion(.failure(.invalidURL))
            return
        }

        session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.someError))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            do {
                let response = try JSONDecoder().decode(NewsResponse.self, from: data)
                let articles = response.articles
                completion(.success(articles))
            } catch {
                completion(.failure(.cannotParseData))
            }
        }.resume()
    }
    ```
1. OK - let's run the app to see our real article titles coming from `newsapi.org`.  
Uh-oh? <image of crash>
1. :confused: That didn't work so well.  
Remember in `week1` we talked about completion blocks? The issue here is that we tried to update UI on a **background thread**. Let's fix this by updating our `ViewController` to reload the UI on the **main thread**:
    ```swift
    override func viewDidLoad() {
        ...
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
    ```
1. *Now* let's run the app to see our real articles coming from `newsapi.org`. :tada: <image of real titles coming from the internet>
1. There's some improvements we can make to our code quality before going further. Let's make our URL creation a bit more flexible:
    ```swift
    class NewsFetcher {
        private let baseURL = "https://newsapi.org"
        private let apiKey = "<YOUR_API_KEY>"
        private let session = URLSession.shared

        func getLatestArticles(_ completion: @escaping (Result<[NewsItem], NewsFetcherError>) -> Void) {
            let endpoint = "/v2/top-headlines"
            let queryParameters = "q=apple&apiKey=\(apiKey)"

            guard let url = URL(string: "\(baseURL)\(endpoint)?\(queryParameters)") else {
                completion(.failure(.invalidURL))
                return
            }
            ...
        }
    }
    ```
1. That code is a little neater. We're not hardcoding values in our url anymore. But we're still using a string. This is what we call `Stringly Typed`. We can do better using `NSURLComponents`:
    ```swift
    func getLatestArticles(_ completion: @escaping (Result<[NewsItem], NewsFetcherError>) -> Void) {
        let endpoint = "/v2/top-headlines"
        let queryParameters = "q=apple&apiKey=\(apiKey)"

        guard let url = createURL(baseURL: baseURL, endpoint: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        ...
    }

    private func createURL(baseURL: String, endpoint: String) -> URL? {
        guard let endpointUrl = URL(string: baseURL)?.appendingPathComponent(endpoint) else { return nil }
        guard var urlComponents = URLComponents(url: endpointUrl, resolvingAgainstBaseURL: false) else { return nil }

        return urlComponents.url
    }
    ```
1. Great - let's try out our neater code to check it still works! Run the app please.
1. Uh-oh. How can we check our URL? Add a breakpoint just after the `guard` statement:
   ```swift
   guard let url = createURL(baseURL: baseURL, endpoint: endpoint) else {   
       completion(.failure(.invalidURL))
       return
   }
   <Add a breakpoint at this line>
   ```
1. Now run the app and use `po url` in the `console` panel to see what the created URL looks like. Copy the URL and paste it into a browser. The error explains the issue:
<image of apiKey missing in Chrome/Safari>
1. :flushed: We forgot about the URL query parameters, including the `apiKey`. Whoops. Let's add them now:
    ```swift
    func getLatestArticles(_ completion: @escaping (Result<[NewsItem], NewsFetcherError>) -> Void) {
        let endpoint = "/v2/top-headlines"
        let parameters = ["q":"apple"]

        guard let url = createURL(baseURL: baseURL, endpoint: endpoint, parameters: parameters) else {
            completion(.failure(.invalidURL))
            return
        }
        ...
    }

    private func createURL(baseURL: String, endpoint: String, parameters: [String: String]) -> URL? {
        guard let endpointUrl = URL(string: baseURL)?.appendingPathComponent(endpoint) else { return nil }
        guard var urlComponents = URLComponents(url: endpointUrl, resolvingAgainstBaseURL: false) else { return nil }

        urlComponents.queryItems = createQueryItems(parameters: parameters)

        return urlComponents.url
    }

    private func createQueryItems(parameters: [String: String]) -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()

        let apiKeyQueryItems = URLQueryItem(name: "apiKey", value: apiKey)
        queryItems.append(apiKeyQueryItems)

        for (queryKey, queryValue) in parameters {
            let newQueryItem = URLQueryItem(name: queryKey, value: queryValue)
            queryItems.append(newQueryItem)
        }

        return queryItems
    }
    ```
1. OK - let's fire up the app and try that out. Now we have a simple app, and clean, bug-free code.


## 3. Interacting with articles
1. Adjust decodable data to include description of article & display

1. Explain that we can now remove this line of code because the storyboard does it for us once we have a prototype cell!
    ```swift
    override func viewDidLoad() {
        super.viewDidLoad()
        // We don't need to manually register the reuse identifier for the cell anymore
        // because the Storyboard does that now. So we can just comment or erase the line bellow
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ArticleCell")
        ...
    }
    ```

1. Then we can set the title and subtitle in the cell
    ```swift
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath)
        let article = articles[indexPath.row]

        cell.textLabel?.text = article.title
        cell.textLabel?.numberOfLines = 0

        cell.detailTextLabel?.text = article.description
        cell.detailTextLabel?.numberOfLines = 0

        return cell
    }
    ```swift

1. Adjust Decodable data to include link to article
1. Open content in a safari web view controller
