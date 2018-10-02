//
//  SearchFilterTests.swift
//  SearchTests
//
//  Created by Hendy Christianto on 02/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import XCTest
@testable import Search

class SearchFilterTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testConvertToJson() {
        let filter = SearchFilter(minPrice: "10",
                                  maxPrice: "20",
                                  wholesale: false,
                                  official: true,
                                  fshop: "1")

        let output = filter.toJson()

        XCTAssert(output["q"] as? String == "samsung",
                  "Expected query is Samsung")
        XCTAssert(output["pmin"] as? String == "10",
                  "Expected pmin is '10'")
        XCTAssert(output["pmax"] as? String == "20",
                  "Expected pmax is '20'")
        XCTAssert(output["wholesale"] as? Bool == false,
                  "Expected wholesale is 'false'")
        XCTAssert(output["official"] as? Bool == true,
                  "Expected official is 'true'")
        XCTAssert(output["fshop"] as? String == "1",
                  "Expected fshop is '1'")
    }
}
