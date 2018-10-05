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
    var view = SearchViewController()

    override func setUp() {
        mockEventHandler = MockSearchEventHandler()

        view.presenter = mockEventHandler
    }

    func testOnViewDidLoadRequestSearch() {
        let initialSearchFilter = SearchFilter()

        view.loadViewIfNeeded()

        view.viewDidLoad()

        XCTAssert(view.isLoading == true,
                  "Expect isLoading is true when requestSearch")
        XCTAssert(mockEventHandler?.invokedOnRequestSearch == true,
                  "Expect invoke requestSearch once")
        XCTAssert(mockEventHandler?.invokedOnRequestSearchParameters?.filter == initialSearchFilter,
                  "Expect requestSearch invoked with default search filter")
        XCTAssert(mockEventHandler?.invokedOnRequestSearchParameters?.start == 0,
                  "Expect requestSearch invoked with start 0")
        XCTAssert(mockEventHandler?.invokedOnRequestSearchParameters?.num == 10,
                  "Expect requestSearch invoked with num 10")
    }

    func testShowSearchResult() {
        let indexPath = IndexPath(row: 0, section: 0)
        let mockData: [[String: Any]] = [
            ["id": 123, "name": "test", "price": "Rp. 20"],
            ["id": 234, "name": "test2", "price": "Rp. 30"],
            ["id": 2345, "name": "test3", "price": "Rp. 40"]
        ]

        var results = [ProductItem]()
        for data in mockData {
            guard let item = ProductItem(json: data) else {
                XCTFail("Failed when creating product item")

                return
            }

            results.append(item)
        }

        view.loadViewIfNeeded()

        view.showSearchResults(searchResults: results, nextPage: 3)

        XCTAssert(view.isLoading == false,
                  "Expect isLoading is false when show search result called")
        XCTAssert(view.collectionView.numberOfItems(inSection: 0) == results.count,
                  "Expect number of items is the same with results.")
        XCTAssert(view.start == 3, "Expect start is 3 after show result")

        guard let cell = view.collectionView(view.collectionView, cellForItemAt: indexPath)
            as? ProductItemCollectionViewCell else {
                XCTFail("Expect cell type is ProductItemCollectionViewCell")

                return
        }

        view.collectionView(view.collectionView, willDisplay: cell, forItemAt: indexPath)

        XCTAssert(cell.labelName.text == results[0].name,
                  "Expect name shown on cell index 0 is same with results on index 0")
        XCTAssert(cell.labelPrice.text == results[0].price,
                  "Expect price shown on cell index 0 is same with results on index 0")
    }

    func testOnScrollLoadMoreSearchResultWhenScrolledMoreThanEightyPercent() {
        let mockData: [[String: Any]] = [
            ["id": 123, "name": "test", "price": "Rp. 20"],
            ["id": 234, "name": "test2", "price": "Rp. 30"]
        ]
        var results = [ProductItem]()
        for data in mockData {
            guard let item = ProductItem(json: data) else {
                XCTFail("Failed when creating product item")

                return
            }

            results.append(item)
        }
        let initialSearchFilter = SearchFilter()
        let dummyScrollView = UIScrollView(frame: UIScreen.main.bounds)
        dummyScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,
                                             height: UIScreen.main.bounds.height * 2)
        dummyScrollView.contentOffset = CGPoint(x: 0, y: dummyScrollView.contentSize.height)

        view.loadViewIfNeeded()

        // Show initial data
        view.showSearchResults(searchResults: results, nextPage: 2)

        view.scrollViewDidScroll(dummyScrollView)

        XCTAssert(view.isLoading == true,
                  "Expect isLoading is true when requestSearch")
        XCTAssert(mockEventHandler?.invokedOnRequestSearch == true,
                  "Expect invoke request search result once")
        XCTAssert(mockEventHandler?.invokedOnRequestSearchParameters?.filter == initialSearchFilter,
                  "Expect requestSearch invoked with default search filter")
        XCTAssert(mockEventHandler?.invokedOnRequestSearchParameters?.start == 2,
                  "Expect requestSearch invoked with start 2")
        XCTAssert(mockEventHandler?.invokedOnRequestSearchParameters?.num == 10,
                  "Expect requestSearch invoked with num 10")
    }

    func testOnScrollLoadMoreSearchResultWhenScrolledLessThanEightyPercent() {
        let dummyScrollView = UIScrollView(frame: UIScreen.main.bounds)
        dummyScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,
                                             height: UIScreen.main.bounds.height * 2)
        dummyScrollView.contentOffset = CGPoint(x: 0, y: 30)

        view.scrollViewDidScroll(dummyScrollView)

        XCTAssert(view.isLoading == false,
                  "Expect isLoading is false")
        XCTAssert(mockEventHandler?.invokedOnRequestSearch == false,
                  "Expect invoke request search result not called")
    }

    func testActionButtonFilterClick() {
        view.onButtonFilterClicked()

        XCTAssert(mockEventHandler?.invokedOnButtonFilterClickedCount == 1,
                  "Expect invoke event handler onButtonFilterClicked once")
        XCTAssert(mockEventHandler?.invokedOnButtonFilterClickedParameters?
            .filter == view.filter,
                  "Expect invoke event handler onButtonFilterClicked once")
    }

    func testReceiveNewSearchFilter() {
        let dummySearchFilter = SearchFilter(minPrice: "10",
                                             maxPrice: "20",
                                             wholesale: true,
                                             official: false,
                                             fshop: "2")

        let mockData: [[String: Any]] = [
            ["id": 123, "name": "test", "price": "Rp. 20"],
            ["id": 234, "name": "test2", "price": "Rp. 30"]
        ]
        var results = [ProductItem]()
        for data in mockData {
            guard let item = ProductItem(json: data) else {
                XCTFail("Failed when creating product item")

                return
            }

            results.append(item)
        }

        view.loadViewIfNeeded()

        // Fill up data first
        view.showSearchResults(searchResults: results, nextPage: 2)

        view.searchFilterDidApply(newFilter: dummySearchFilter)

        XCTAssert(view.filter == dummySearchFilter, "Expect new filter is applied.")
        XCTAssert(view.start == 0,
                  "Expect when new search filter applied, start is 0")
        XCTAssert(view.collectionView.numberOfItems(inSection: 0) == 0,
                  "Expect when new search filter applied, collection view is empty")
        XCTAssert(view.searchResults.isEmpty,
                  "Expect when new search filter applied, search result is empty.")
        XCTAssert(view.isLoading == true,
                  "Expect isLoading is true when requestSearch")
        XCTAssert(mockEventHandler?.invokedOnRequestSearch == true,
                  "Expect when new search filter applied, invoke api request once")
        XCTAssert(mockEventHandler?.invokedOnRequestSearchParameters?.start == 0,
                  "Expect requestSearch invoked with start 0")
        XCTAssert(mockEventHandler?.invokedOnRequestSearchParameters?.num == 10,
                  "Expect requestSearch invoked with num 10")
    }

    func testShowAlert() {
        let apiError = ApiError(type: .networkError)

        view.showApiError(apiError: apiError)

        XCTAssert(view.alert != nil,
                  "Expect alert is not nil")
        XCTAssert(view.alert?.message == apiError.message,
                  "Expect alert shown with the same message")
    }
}
