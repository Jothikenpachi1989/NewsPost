//
//  APIManager.swift
//  NewsApp
//
//  Created by Jothiram Elangovan on 24/11/18.
//

import UIKit

class APIManager: NSObject {
  
    static let shared = APIManager()
    private let hostName = "https://api.nytimes.com/svc/mostpopular/v2/mostviewed"
    private let section = "all-sections"
    private let pages = "1"
    private let apiKey = "a324df68390143ef8bd776b9b6395647"
    private let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    
    override private init() {
        urlSession.configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    }
    
    func getNewsData(_ completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let confirmedUrl = getUrl() else {
            return
        }
        let datatTask = urlSession.dataTask(with: confirmedUrl) { (data, response, error) in
            completionHandler(data, response, error)
        }
        datatTask.resume()
    }
    
    func getImageFromUrl(_ url: URL, completionHandler: @escaping (UIImage?) -> Void) {
        let datatTask = urlSession.dataTask(with: url) { (data, response, error) in
            if let confirmedData = data {
                completionHandler(UIImage(data: confirmedData))
            } else {
                completionHandler(nil)
            }
        }
        datatTask.resume()
    }
    
    private func getUrl() -> URL? {
        let urlString = hostName + "/\(section)/\(pages).json"
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = getQueryStringParameter()
        return urlComponents?.url
    }
    
    private func getQueryStringParameter() -> [URLQueryItem] {
        let queryItemAPIKey = URLQueryItem(name: "apikey", value: apiKey)
        return [queryItemAPIKey]
    }
}
