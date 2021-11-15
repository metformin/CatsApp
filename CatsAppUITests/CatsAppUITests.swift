//
//  CatsAppUITests.swift
//  CatsAppUITests
//
//  Created by Darek on 12/11/2021.
//

import XCTest

class CatsAppUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testIfCatsCollectionViewLoadingWithData() throws {
        let app = XCUIApplication()
        app.launch()
    
        let collectionViewsQuery = app.collectionViews
        let cells = collectionViewsQuery.children(matching: .cell).element
        
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: cells, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        let cellCount = collectionViewsQuery.children(matching: .cell).count
        XCTAssertEqual(cellCount, 5)
    }
}
