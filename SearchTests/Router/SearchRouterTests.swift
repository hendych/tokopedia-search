//
//  SearchRouterTests.swift
//  SearchTests
//
//  Created by Hendy Christianto on 03/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import XCTest
@testable import Search

class SearchRouterTests: XCTestCase {

    let router = SearchRouter()

    func testPresentSearchFilterView() {
        let mockSearchView = MockSearchView()

        router.presentSearchFilterView(onView: mockSearchView, animated: false)

        XCTAssert(mockSearchView.invokedPresentCount == 1,
                  "Expect search view invoke present once")

        guard let navController = mockSearchView.invokedPresentParameters?.viewControllerToPresent
            as? UINavigationController else {
                XCTFail("Expect presented view is navigation controller")

                return
        }

        XCTAssert(navController.viewControllers.first is SearchFilterViewController,
                  "Expect search view is presenting SearchFilterViewController")
    }
}
