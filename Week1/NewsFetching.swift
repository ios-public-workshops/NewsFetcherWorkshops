import Foundation

enum NewsFetcherError: Error {
    case someError
}

class NewsFetcher {
    func getLatestArticles(_ completion: @escaping (Result<[NewsItem], NewsFetcherError>) -> Void) {
        let articles = [
            NewsItem(headline: "Apple won't offer a Netflix-like quantity of TV shows"),
            NewsItem(headline: "How to Make Store-Bought Barbecue Sauce Taste Better"),
            NewsItem(headline: "What to Do If Your Mac Won't Update to Windows 10 Version 1903"),
            NewsItem(headline: "Bullet's captioned snippets make podcasts a lot more shareable"),
            NewsItem(headline: "Xiaomi subtly clones Apple's Memoji with 'Mimoji'"),
            NewsItem(headline: "There’s only one important question to ask about Apple’s future"),
            NewsItem(headline: "EV startup Rivian has poached dozens from Ford, McLaren, Tesla, and Faraday Future"),
            NewsItem(headline: "FCC filing is latest evidence that Apple will soon update its most affordable MacBook Pro"),
            NewsItem(headline: "Apple Sans Ive"),
            NewsItem(headline: "Disrupt SF 4-day flash sale: save an additional $300 off passes"),
            NewsItem(headline: "U.S. retail group offers to help antitrust investigators in going after Amazon and Google"),
            NewsItem(headline: "Apple TV+ Might Just Fuck After All"),
            NewsItem(headline: "Apple's Project Titan Dreamed Up a Car With Retractable Bumpers"),
            NewsItem(headline: "He’s Spent Just One Night on His Private Island. He’s Had Enough."),
            NewsItem(headline: "New details have emerged about Jony Ive leaving Apple"),
            NewsItem(headline: "Apple MacBook, Fire TV Recast, Nespresso Essenza Mini, Echo Dot, and more deals for July 2"),
            NewsItem(headline: "Samsung sets a date for its big Galaxy Note 10 reveal"),
            NewsItem(headline: "Let's set some ground rules to safely build, test, and drive robo-cars"),
            NewsItem(headline: "Retailers all but beg FTC to take action against Google, Amazon"),
            NewsItem(headline: "Xiaomi blatantly ripped off Apple's Memoji and created 'Mimoji'")
        ]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(.success(articles))
        }
    }
}

struct NewsItem {
    let headline: String
}
