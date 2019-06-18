# Week 2 - Networking
After building an app that shows a list of news using fake data, in this class we are going to create the networking layer to actully consume data from the newsapi.org service.

### Prerequisites:
Go to [newsapi.org](https://newsapi.org/) and create an API Key for you.

### Steps
1. Remove mocked data source
1. Adds pull to refresh
1. Trigger the network call after pulling to refresh
1. Call the real endpoint (hardcoded) using URLSession and return real data
1. Adjust the TableView to use the newly returned data
1. Introduce the concept of closures and async operations
1. Introduce the concept of URLComponents and how to build URLs safely on iOS
1. Build the URL to call the endpoint for returning articles
1. Adjust Decodable data to include link to article
