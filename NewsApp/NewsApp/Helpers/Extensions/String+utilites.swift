//
//  String+utilites.swift
//  NewsApp
//
//  Created by Jothiram Elangovan on 24/11/18.
//

import Foundation

public extension String {
    func dateFromString(format: Constants.DateFormat) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.date(from: self)
    }
}
