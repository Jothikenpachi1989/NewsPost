//
//  DataParser.swift
//  NewsApp
//
//  Created by Jothiram Elangovan on 24/11/18.
//

import UIKit


class DataParser: NSObject {
    
    static let shared = DataParser()
    var dataSource = [NewsList]()
    
    override private init() {
        
    }
    
    func parseData(_ jsonData: Data, completionHandler: @escaping(String?) -> Void) {
        guard let confirmedJsonDict = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any] else {
            completionHandler("Parse error")
            return
        }
        
        completionHandler(parseNewsJson(confirmedJsonDict))
        
    }
    
    func parseNewsJson(_ jsonDict: [String: Any]?) -> String? {
        guard let confirmedJsondict = jsonDict,
            let confirmedResults = confirmedJsondict["results"] as? [[String: Any]] else {
            return "News data not available"
        }
        
        dataSource.removeAll()
        
        for news in confirmedResults {
            var newsData = NewsList(title: "", newsUrl: nil, byLine: nil, publishingDateString: nil, publishingDate: nil, section: nil, source: nil, abstract: nil, imageCaption: nil, imageCopyright: nil, imageUrl: nil)
            newsData.parseData(news)
            dataSource.append(newsData)
        }
        
        return nil
    }
    
    public static func loadJSONWithFileName(_ fileName: String, bundle: Bundle) -> [String: Any]? {
       
        let fileNameNoExension = fileName.replacingOccurrences(of: ".json", with: "")
        
        guard let confirmedPath = bundle.path(forResource: fileNameNoExension, ofType: "json") else {
            print("Could not find \(fileNameNoExension).json")
            return nil
        }
        
        do {
            
            let jsonString = try NSString(contentsOfFile: confirmedPath, encoding: String.Encoding.utf8.rawValue)
            
            if let confirmedJSONData = jsonString.data(using: String.Encoding.utf8.rawValue),
                let json = try JSONSerialization.jsonObject(with: confirmedJSONData, options: .mutableContainers) as? [String: Any] {
                return json
            } else {
                print("Could not load \(fileNameNoExension).json)")
            }
            
        } catch {
            
            print("Could not load \(fileNameNoExension).json \(error)")
            
        }
        
        return nil
        
    }
}
