//
//  DataParserTests.swift
//  NewsAppTests
//
//  Created by Jothiram Elangovan on 24/11/18.
//

import XCTest
@testable import NewsApp

class DataParserTests: NewsAppTests {

    let exceptedNewsDataCount = 20
    override func setUp() {
        guard let confirmedJsonData = DataParser.loadJSONWithFileName(testDataFile, bundle: Bundle.main) else {
            assertionFailure("Test data cannot be loaded")
            return
        }
        let _ = DataParser.shared.parseNewsJson(confirmedJsonData)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNewsDataParsedCorrectly() {
        assert(DataParser.shared.dataSource.count == exceptedNewsDataCount, "All the news data is not parsed properly")
    }

}
