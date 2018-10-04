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

        mockView?.loadViewIfNeeded()

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

        presenter?.foundSearchResult(results: results, nextPage: 2)

        XCTAssert(mockView?.invokedShowSearchResultsCount == 1,
                  "Expect showSearchResults called once")
        XCTAssert(mockView?.invokedShowSearchResultsParameters?.searchResults == results,
                  "Expect showSearchResults invoked with parameter results")
        XCTAssert(mockView?.invokedShowSearchResultsParameters?.nextPage == 2,
                  "Expect showSearchResults invoked with parameter next page 2")
    }

    func testHandleEventOnRequestSearch() {
        let searchFilter = SearchFilter(minPrice: "0", maxPrice: "20", wholesale: true,
                                        official: true, fshop: "1")
        presenter?.onRequestSearch(withFilter: searchFilter, start: 1, num: 1)

        XCTAssert(mockInteractor?.invokedRequestSearchCount == 1, "Expect requestSearch called once")
        XCTAssert(mockInteractor?.invokedRequestSearchParameters?.filter == searchFilter,
                  "Expected search filter parameter sent is not same!")
        XCTAssert(mockInteractor?.invokedRequestSearchParameters?.num == 1,
                  "Expected num parameter sent is not same!")
        XCTAssert(mockInteractor?.invokedRequestSearchParameters?.start == 1,
                  "Expected num parameter start is not same!")
    }

    func testEventOnButtonClicked() {
        presenter?.onButtonFilterClicked()

        XCTAssert(mockRouter?.invokedPresentSearchFilterViewCount == 1,
                  "Expect router to invoke presentSearchFilterView once")
        XCTAssert(mockRouter?.invokedPresentSearchFilterViewParameters?.view?
            .isEqual(mockView) ?? false,
                  "Expect parameter sent is the same view injected from presenter")
    }
}
