//
//  XCTestCase+Utilities.swift
//  NewsAppUITests
//
//  Created by Jothiram Elangovan on 24/11/18.
//

import XCTest

enum Duration: TimeInterval {
    
    case second = 1
    case minute = 60
    case twoMinutes = 120
    case fiveMinutes = 300
    case tenMinutes = 600
    
}

extension XCTestCase {
    
    func wait(forObjectToExist object: Any, timeout: Duration = .minute) {
        
        let predicate = NSPredicate(format: "exists == true")
        expectation(for: predicate, evaluatedWith: object, handler: nil)
        waitForExpectations(timeout: timeout.rawValue, handler: nil)
        
    }
    
    func wait(forObjectToLeave object: Any, timeout: Duration = .minute) {
        
        let predicate = NSPredicate(format: "exists == false")
        expectation(for: predicate, evaluatedWith: object, handler: nil)
        waitForExpectations(timeout: timeout.rawValue, handler: nil)
        
    }
    
    func wait(forTable object: Any, untilCellCountEquals count: UInt, timeout: Duration = .minute) {
        
        let predicate = NSPredicate(format: "count == \(count)")
        expectation(for: predicate, evaluatedWith: object, handler: nil)
        waitForExpectations(timeout: timeout.rawValue, handler: nil)
        
    }
    
    func wait(forTable object: Any, untilCellCountGreaterThan count: UInt, timeout: Duration = .minute) {
        
        let predicate = NSPredicate(format: "count > \(count)")
        expectation(for: predicate, evaluatedWith: object, handler: nil)
        waitForExpectations(timeout: timeout.rawValue, handler: nil)
    }

}
