//
//  NewsAppTests.swift
//  NewsAppTests
//
//  Created by Jothiram Elangovan on 24/11/18.
//

import XCTest
@testable import NewsApp

class NewsAppTests: XCTestCase {

    let testDataFile = "TestData"
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testJsonParsingPerformance() {
        // This is an example of a performance test case.
        guard let confirmedJsonData = DataParser.loadJSONWithFileName(testDataFile, bundle: Bundle.main) else {
            assertionFailure("Test data cannot be loaded")
            return
        }
        self.measure {
            if let confirmedError = DataParser.shared.parseNewsJson(confirmedJsonData) {
                assertionFailure(confirmedError)
            }
        }
    }

}
