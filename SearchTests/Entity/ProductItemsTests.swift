//
//  ProductItemsTests.swift
//  SearchTests
//
//  Created by Hendy Christianto on 02/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import XCTest
@testable import Search

class ProductItemsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSerializeJsonProductItem() {
        let json: [String: Any] = ["id": 0,
                                   "name": "kabel",
                                   "uri": "abc",
                                   "image_uri": "bcd",
                                   "image_uri_700": "ccc",
                                   "price": "Rp. 1",
                                   "price_range": "20"]

        guard let productItem = ProductItem(json: json) else {
            XCTFail("Failed to create product item")

            return
        }

        XCTAssert(productItem.id == 0, "Expected id is '0'")
        XCTAssert(productItem.name == "kabel", "Expected name is 'kabel'")
        XCTAssert(productItem.uri == "abc", "Expected uri is 'abc'")
        XCTAssert(productItem.imageUri == "bcd", "Expected imageUri is 'bcd'")
        XCTAssert(productItem.imageUri700 == "ccc", "Expected imageUri700 is 'ccc'")
        XCTAssert(productItem.price == "Rp. 1", "Expected imageUri is 'Rp. 1'")
        XCTAssert(productItem.priceRange == "20", "Expected priceRange is '20'")
    }

    func testSerializeJsonProductItemWithInvalidJson() {
        let productItem = ProductItem(json: ["a", "b"])

        XCTAssert(productItem == nil, "Expected product item is nil")
    }
}
