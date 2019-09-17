import Foundation
import UIKit

enum ImageDownloaderError: Error {
    case someError
    case invalidData
    case cannotParseData
}

struct ImageDownloader {
    private let session: URLSession
    
    init() {
        let configuration = URLSession.shared.configuration
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        session = URLSession(configuration: configuration)
    }

    @discardableResult func downloadImage(url: URL, completion: @escaping (Result<UIImage, ImageDownloaderError>) -> Void) -> URLSessionDataTask {
        let task = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.someError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let image = UIImage(data: data) else {
                completion(.failure(.cannotParseData))
                return
            }
            
            completion(.success(image))
            
        }
        task.resume()
        return task
    }
}
