//
//  CatsAppTests.swift
//  CatsAppTests
//
//  Created by Darek on 12/11/2021.
//

import XCTest
@testable import CatsApp

class CatsJsonDecoderUnitTest: XCTestCase {
    
    var catsApi: CatsAPIService!
    var catsJsonDecoder: CatsJsonDecoder!
        
    override func setUp() {
        self.catsApi = CatsApiMock()
        self.catsJsonDecoder = CatsJsonDecoder()
    }

    func testRetrieveCatsValidResponse(){
        var decodedCats: [Cat]?
        catsApi.fetchCats { [weak self] data in
            decodedCats = try? self?.catsJsonDecoder.decode(json: data)
        }
        XCTAssertNotNil(decodedCats)
        XCTAssertEqual(decodedCats?.first?.name, "Max")
    }
}
