//
//  ShopTypeViewTests.swift
//  SearchTests
//
//  Created by Hendy Christianto on 05/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import XCTest
@testable import Search

class ShopTypeViewTests: XCTestCase {
    func testShopTypeInitWithNilInitialShopTypesHasTwoRows() {
        let view = ShopTypeViewController(initialShopType: nil)

        let numOfRows = view.tableView(view.tableView, numberOfRowsInSection: 0)

        XCTAssert(numOfRows == 2, "Expect shop type view has 2 rows")
    }

    func testShopTypeCellHeight() {
        let view = ShopTypeViewController(initialShopType: nil)
        let anyIndexPath = IndexPath(row: 0, section: 0)

        let height = view.tableView(view.tableView, heightForRowAt: anyIndexPath)

        XCTAssert(height == CheckBoxTableViewCell.getHeight(),
                  "Expect height of cell is same with CheckBoxTableViewCell.getHeight()")
    }
}
