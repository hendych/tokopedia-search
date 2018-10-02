//
//  SearchInteractorTests.swift
//  SearchTests
//
//  Created by Hendy Christianto on 02/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import XCTest
@testable import Search

class SearchInteractorTests: XCTestCase {

    var mockService: MockSearchService?
    var mockOutput: MockSearchInteractorOutput?
    var interactor: SearchInteractor?

    override func setUp() {
        let service = MockSearchService()

        mockOutput = MockSearchInteractorOutput()
        mockService = service

        interactor = SearchInteractor(service: service)
        interactor?.output = mockOutput
    }

    func testRequestSearchSuccess() {
        let searchFilter = SearchFilter(minPrice: "0", maxPrice: "20", wholesale: true,
                                        official: true, fshop: "1")
        let mockData: [[String: Any]] = [
            ["id": 123, "name": "test"],
            ["id": 234, "name": "test2"]
        ]
        let mockResponse: [String: [[String: Any]]] = ["data": mockData]
        var expectedResults = [ProductItem]()

        mockService?.stubbedRequestSearchCompletionResult = (mockResponse, nil)
        for data in mockData {
            guard let item = ProductItem(json: data) else {
                XCTFail("Failed when creating product item")

                return
            }

            expectedResults.append(item)
        }

        interactor?.requestSearch(withFilter: searchFilter, start: 10, num: 5)

        XCTAssert(mockOutput?.invokedFoundSearchResultCount == 1,
                  "Expect foundSearchResult called once")
        XCTAssert(mockOutput?.invokedFoundApiError == false,
                  "Expect foundApiError is not invoked")
        XCTAssert(mockOutput?.invokedFoundSearchResultParameters?.nextPage == 15,
                  "Expect foundApiError invoked with nextPage start + num")

        guard let results = mockOutput?.invokedFoundSearchResultParameters?.results else {
            XCTFail("Expect results is not nil")

            return
        }

        XCTAssert(results == expectedResults, "Expected result is not the same!")
    }

    func testRequestSearchFailed() {
        let searchFilter = SearchFilter(minPrice: "0", maxPrice: "20", wholesale: true,
                                        official: true, fshop: "1")

        let expectedError = ApiError(type: .networkError)

        mockService?.stubbedRequestSearchCompletionResult = (nil, expectedError)

        interactor?.requestSearch(withFilter: searchFilter, start: 0, num: 5)

        XCTAssert(mockOutput?.invokedFoundSearchResult == false,
                  "Expect foundSearchResult is not invoked")
        XCTAssert(mockOutput?.invokedFoundApiErrorCount == 1,
                  "Expect foundApiError called once")

        guard let error = mockOutput?.invokedFoundApiErrorParameters?.error else {
            XCTFail("Expect error is not nil")

            return
        }

        XCTAssert(error == expectedError, "Expected result is not the same!")
    }
}
