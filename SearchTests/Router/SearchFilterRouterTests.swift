//
//  SearchFilterRouterTests.swift
//  SearchTests
//
//  Created by Hendy Christianto on 03/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import XCTest
@testable import Search

class SearchFilterRouterTests: XCTestCase {
    let router = SearchFilterRouter()

    func testPushShopTypeView() {
        let mockSearchFilterView = MockSearchFilterView()
        let navController = UINavigationController(rootViewController: mockSearchFilterView)

        router.pushShopTypeViewController(from: mockSearchFilterView, animated: false)

        XCTAssert(navController.viewControllers.count == 2, "Expect navigation controller stack is 2")
        XCTAssert(navController.viewControllers.last is ShopTypeViewController,
                  "Expect search view is presenting ShopTypeViewController")
    }
}
