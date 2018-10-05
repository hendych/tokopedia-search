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
        let router = MockSearchFilterRouter(initialSearchFilter: nil, delegate: nil)
        let interactor = MockSearchFilterInteractorInput()

        mockView = MockSearchFilterView(initialSearchFilter: SearchFilter())
        mockRouter = router
        mockInteractor = interactor

        presenter = SearchFilterPresenter(interactor: interactor, router: router)
        presenter?.view = mockView
    }

    func testHandleEventOnButtonCloseClicked() {
        presenter?.onButtonCloseClicked()

        XCTAssert(mockView?.invokedDismissCount == 1, "Expect invoke dismiss once")
    }

    func testHandlerShopTypeClicked() {
        let initialShopType = [ShopType.officialStore]
        presenter?.onShopTypeClicked(initialShopType: initialShopType)

        XCTAssert(mockRouter?.invokedPushShopTypeViewControllerCount == 1,
                  "Expect calling router with pushShopTypeViewController once")
        XCTAssert(mockRouter?.invokedPushShopTypeViewControllerParameters?
            .initialShopType == initialShopType,
                  "Expected parameter initial shop type is not same")
        XCTAssert(mockRouter?.invokedPushShopTypeViewControllerParameters?
            .view?.isEqual(mockView) ?? false,
                  "Expect calling router with pushShopTypeViewController once")
    }
}
