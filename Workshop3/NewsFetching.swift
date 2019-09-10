import Foundation

#if swift(>=5.0)
#else
/// Result is a native language feature of Swift 5.0.
/// We're manually adding it here to make our code example compatible with older versions of Xcode and Swift 4.0.
public enum Result<Success, Failure: Error> {
    /// A success, storing a `Success` value.
    case success(Success)
    
    /// A failure, storing a `Failure` value.
    case failure(Failure)
}
#endif

enum NewsFetcherError: Error {
    case someError
    case invalidURL
    case invalidData
    case cannotParseData
}

struct NewsResponse: Decodable {
    let status: String
    let totalResults: Int
    let articles: [NewsItem]
}

struct NewsItem: Decodable {
    let title: String
    let description: String
    let url: URL
    let urlToImage: URL?
}

class NewsFetcher {
    private let baseURL = "https://newsapi.org"
    private let apiKey = "d617892bff1f4fd88d62deb71bb74d52"
    private let session = URLSession.shared

    func getLatestArticles(_ completion: @escaping (Result<[NewsItem], NewsFetcherError>) -> Void) {
        let endpoint = "/v2/top-headlines"
        let parameters = ["q":"apple"]
        
        guard let url = createURL(baseURL: baseURL, endpoint: endpoint, parameters: parameters) else {
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
}
