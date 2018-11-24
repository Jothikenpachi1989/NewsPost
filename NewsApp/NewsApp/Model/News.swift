//
//  News.swift
//  NewsApp
//
//  Created by Jothiram Elangovan on 24/11/18.
//

import Foundation

struct NewsList {
    var title: String
    var newsUrl: String?
    var byLine: String?
    var publishingDateString: String?
    var publishingDate: Date?
    var section: String?
    var source: String?
    var abstract: String?
    var imageCaption: String?
    var imageCopyright: String?
    var imageUrl: String?
    
    mutating func    parseData(_ newsData: [String: Any]) {
        
        if let confirmedNewsTitle = newsData["title"] as? String {
            self.title = confirmedNewsTitle
        }
        self.byLine = newsData["byline"] as? String
        self.publishingDateString = newsData["published_date"] as? String
        self.section = newsData["section"] as? String
        self.source = newsData["source"] as? String
        self.abstract = newsData["abstract"] as? String
        self.newsUrl = newsData["url"] as? String
        
        if let confirmedDateString = self.publishingDateString,
            let confirmedPublishingDate = confirmedDateString.dateFromString(format: .simpleYMD) {
            self.publishingDate = confirmedPublishingDate
        }
        
        guard let confirmedMediaArray = newsData["media"] as? [[String: Any]],
            confirmedMediaArray.count > 0 else {
            return
        }
        let mediaData = confirmedMediaArray.first
        self.imageCaption = mediaData?["caption"] as? String
        self.imageCopyright = mediaData?["copyright"] as? String
        
        guard let confirmedImageArray = mediaData?["media-metadata"] as? [[String: Any]], confirmedImageArray.count > 0 else {
            return
        }
        let imageData = confirmedImageArray.first
        self.imageUrl = imageData?["url"] as? String
    }
}
