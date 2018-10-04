//
//  MockSearchFilterEventHandler.swift
//  SearchTests
//
//  Created by Hendy Christianto on 03/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import Foundation
@testable import Search

class MockSearchFilterEventHandler: SearchFilterEventHandler {
    var invokedOnButtonCloseClicked = false
    var invokedOnButtonCloseClickedCount = 0
    func onButtonCloseClicked() {
        invokedOnButtonCloseClicked = true
        invokedOnButtonCloseClickedCount += 1
    }
    var invokedOnShopTypeClicked = false
    var invokedOnShopTypeClickedCount = 0
    var invokedOnShopTypeClickedParameters: (initialShopType: [ShopType]?, Void)?
    var invokedOnShopTypeClickedParametersList = [(initialShopType: [ShopType]?, Void)]()
    func onShopTypeClicked(initialShopType: [ShopType]?) {
        invokedOnShopTypeClicked = true
        invokedOnShopTypeClickedCount += 1
        invokedOnShopTypeClickedParameters = (initialShopType, ())
        invokedOnShopTypeClickedParametersList.append((initialShopType, ()))
    }
}
