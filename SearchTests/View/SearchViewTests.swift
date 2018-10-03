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

    func testOnViewWillAppearRequestSearch() {
        let initialSearchFilter = SearchFilter()

        view.viewWillAppear(false)

        XCTAssert(mockEventHandler?.invokedOnRequestSearchCount == 1,
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

        view.showSearchResults(searchResults: results, nextPage: 10)

        XCTAssert(view.collectionView.numberOfItems(inSection: 0) == results.count,
                  "Expect number of items is the same with results.")
        XCTAssert(view.start == 10, "Expect start is 10 after show result")

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

    func testShowSearchResultsPagination() {
        let mockData1: [[String: Any]] = [
            ["id": 123, "name": "test", "price": "Rp. 20"],
            ["id": 234, "name": "test2", "price": "Rp. 30"]
        ]

        let mockData2: [[String: Any]] = [
            ["id": 2345, "name": "test3", "price": "Rp. 40"]
        ]

        var results1 = [ProductItem]()
        var results2 = [ProductItem]()
        for data in mockData1 {
            guard let item = ProductItem(json: data) else {
                XCTFail("Failed when creating product item")

                return
            }

            results1.append(item)
        }

        for data in mockData2 {
            guard let item = ProductItem(json: data) else {
                XCTFail("Failed when creating product item")

                return
            }

            results2.append(item)
        }

        view.showSearchResults(searchResults: results1, nextPage: 2)
        view.showSearchResults(searchResults: results2, nextPage: 3)

        XCTAssert(view.collectionView.numberOfItems(inSection: 0) == results1.count + results2.count,
                  "Expect number of items is appending with total of 3")
        XCTAssert(view.collectionView.numberOfItems(inSection: 0) == results1.count + results2.count,
                  "Expect number of items is appending with total of 3")
        XCTAssert(view.start == 3, "Expect start is 3 after show result pagination")
    }
}
