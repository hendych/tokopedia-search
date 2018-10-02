//
//  SearchViewTests.swift
//  SearchTests
//
//  Created by Hendy Christianto on 03/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import XCTest
@testable import Search

class SearchViewTests: XCTestCase {

    var mockEventHandler: MockSearchEventHandler?
    var view: SearchViewController?

    override func setUp() {
        mockEventHandler = MockSearchEventHandler()

        view = SearchViewController()
        view?.presenter = mockEventHandler
    }

    func testOnViewWillAppearRequestSearch() {
        let initialSearchFilter = SearchFilter()

        view?.viewWillAppear(false)

        XCTAssert(mockEventHandler?.invokedOnRequestSearchCount == 1,
                  "Expect invoke requestSearch once")
        XCTAssert(mockEventHandler?.invokedOnRequestSearchParameters?.filter == initialSearchFilter,
                  "Expect requestSearch invoked with default search filter")
        XCTAssert(mockEventHandler?.invokedOnRequestSearchParameters?.start == 0,
                  "Expect requestSearch invoked with start 0")
        XCTAssert(mockEventHandler?.invokedOnRequestSearchParameters?.num == 10,
                  "Expect requestSearch invoked with num 10")
    }
}
