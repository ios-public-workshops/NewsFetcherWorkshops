# Week 2 - Networking
Today we are going to make our app _really_ talk to the internet! We are going to add networking functionality and retrieve data from the public newsapi.org service.

### Prerequisites:
- Complete [week 1 tutorial](../Week1/Week1-Creation.md)!

## 1. Downloading real data
1. Register a new API key at [newsapi.org](https://newsapi.org/register/). <image of newsapi.org form filled out>
1. Remove mocked data source
1. Adds pull to refresh
1. Trigger the network call after pulling to refresh
1. Call the real endpoint (hardcoded) using URLSession and return real data
1. Adjust the TableView to use the newly returned data
1. Introduce the concept of closures and async operations
1. Introduce the concept of URLComponents and how to build URLs safely on iOS
1. Build the URL to call the endpoint for returning articles
1. Adjust Decodable data to include link to article
1. Open content in a safari web view controller
