//
//  NewsAppUITests.swift
//  NewsAppUITests
//
//  Created by Jothiram Elangovan on 24/11/18.
//

import XCTest

class NewsAppUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSyncPerformance() {
        let app = XCUIApplication()
        app.launch()
        
        self.measure {
            wait(forObjectToExist: app.navigationBars["Most Viewed News"], timeout: .minute)
        }
    }

}
