//
//  SearchFilterViewTests.swift
//  SearchTests
//
//  Created by Hendy Christianto on 03/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import XCTest
@testable import Search

class SearchFilterViewTests: XCTestCase {

    var mockEventHandler: MockSearchFilterEventHandler?
    var view = SearchFilterViewController()

    override func setUp() {
        mockEventHandler = MockSearchFilterEventHandler()

        view.presenter = mockEventHandler
    }

    func testActionOnButtonCloseClicked() {
        view.onButtonCloseClicked()

        XCTAssert(mockEventHandler?.invokedOnButtonCloseClickedCount == 1,
                  "Expect invoke event handler onButtonCloseClicked once")
    }
}
