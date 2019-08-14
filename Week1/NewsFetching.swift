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
}

class NewsFetcher {
    func getLatestArticles(_ completion: @escaping (Result<[NewsItem], NewsFetcherError>) -> Void) {
        let articles = [
            NewsItem(title: "Apple won't offer a Netflix-like quantity of TV shows"),
            NewsItem(title: "How to Make Store-Bought Barbecue Sauce Taste Better"),
            NewsItem(title: "What to Do If Your Mac Won't Update to Windows 10 Version 1903"),
            NewsItem(title: "Bullet's captioned snippets make podcasts a lot more shareable"),
            NewsItem(title: "Xiaomi subtly clones Apple's Memoji with 'Mimoji'"),
            NewsItem(title: "There’s only one important question to ask about Apple’s future"),
            NewsItem(title: "EV startup Rivian has poached dozens from Ford, McLaren, Tesla, and Faraday Future"),
            NewsItem(title: "FCC filing is latest evidence that Apple will soon update its most affordable MacBook Pro"),
            NewsItem(title: "Apple Sans Ive"),
            NewsItem(title: "Disrupt SF 4-day flash sale: save an additional $300 off passes"),
            NewsItem(title: "U.S. retail group offers to help antitrust investigators in going after Amazon and Google"),
            NewsItem(title: "Apple TV+ Might Just Fuck After All"),
            NewsItem(title: "Apple's Project Titan Dreamed Up a Car With Retractable Bumpers"),
            NewsItem(title: "He’s Spent Just One Night on His Private Island. He’s Had Enough."),
            NewsItem(title: "New details have emerged about Jony Ive leaving Apple"),
            NewsItem(title: "Apple MacBook, Fire TV Recast, Nespresso Essenza Mini, Echo Dot, and more deals for July 2"),
            NewsItem(title: "Samsung sets a date for its big Galaxy Note 10 reveal"),
            NewsItem(title: "Let's set some ground rules to safely build, test, and drive robo-cars"),
            NewsItem(title: "Retailers all but beg FTC to take action against Google, Amazon"),
            NewsItem(title: "Xiaomi blatantly ripped off Apple's Memoji and created 'Mimoji'")
        ]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(.success(articles))
        }
    }
}

struct NewsItem {
    let title: String
}
