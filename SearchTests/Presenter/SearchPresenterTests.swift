//
//  SearchPresenterTests.swift
//  SearchTests
//
//  Created by Hendy Christianto on 02/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import XCTest
@testable import Search

class SearchPresenterTests: XCTestCase {

    var mockRouter: MockSearchRouter?
    var mockView: MockSearchView?
    var mockInteractor: MockSearchInteractorInput?
    var presenter: SearchPresenter?

    override func setUp() {
        let router = MockSearchRouter()
        let interactor = MockSearchInteractorInput()

        mockView = MockSearchView()
        mockRouter = router
        mockInteractor = interactor

        presenter = SearchPresenter(interactor: interactor, router: router)
        presenter?.view = mockView
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOutputFoundSearchResult() {
        let mockData: [[String: Any]] = [
            ["id": 123, "name": "test"],
            ["id": 234, "name": "test2"]
        ]
        var results = [ProductItem]()

        for data in mockData {
            guard let item = ProductItem(json: data) else {
                XCTFail("Failed when creating product item")

                return
            }

            results.append(item)
        }

        presenter?.foundSearchResult(results: results, nextPage: 20)

        XCTAssert(mockView?.invokedShowSearchResultsCount == 1,
                  "Expect showSearchResults called once")
        XCTAssert(mockView?.invokedShowSearchResultsParameters?.searchResults == results,
                  "Expect showSearchResults invoked with parameter results")
        XCTAssert(mockView?.invokedShowSearchResultsParameters?.nextPage == 20,
                  "Expect showSearchResults invoked with parameter next page 20")
    }
}
