//
//  SearchFilterPresenterTests.swift
//  SearchTests
//
//  Created by Hendy Christianto on 03/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import XCTest
@testable import Search

class SearchFilterPresenterTests: XCTestCase {

    var mockRouter: MockSearchFilterRouter?
    var mockView: MockSearchFilterView?
    var mockInteractor: MockSearchFilterInteractorInput?
    var presenter: SearchFilterPresenter?

    override func setUp() {
        let router = MockSearchFilterRouter()
        let interactor = MockSearchFilterInteractorInput()

        mockView = MockSearchFilterView()
        mockRouter = router
        mockInteractor = interactor

        presenter = SearchFilterPresenter(interactor: interactor, router: router)
        presenter?.view = mockView
    }

    func testHandleEventOnButtonCloseClicked() {
        presenter?.onButtonCloseClicked()

        XCTAssert(mockView?.invokedDismissCount == 1, "Expect invoke dismiss once")
    }
}
