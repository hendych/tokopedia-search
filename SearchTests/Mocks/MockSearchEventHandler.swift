//
//  MockSearchEventHandler.swift
//  SearchTests
//
//  Created by Hendy Christianto on 03/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import Foundation
@testable import Search

class MockSearchEventHandler: SearchEventHandler {
    var invokedOnRequestSearch = false
    var invokedOnRequestSearchCount = 0
    var invokedOnRequestSearchParameters: (filter: SearchFilter, start: Int, num: Int)?
    var invokedOnRequestSearchParametersList = [(filter: SearchFilter, start: Int, num: Int)]()
    func onRequestSearch(withFilter filter: SearchFilter, start: Int, num: Int) {
        invokedOnRequestSearch = true
        invokedOnRequestSearchCount += 1
        invokedOnRequestSearchParameters = (filter, start, num)
        invokedOnRequestSearchParametersList.append((filter, start, num))
    }
    var invokedOnButtonFilterClicked = false
    var invokedOnButtonFilterClickedCount = 0
    func onButtonFilterClicked() {
        invokedOnButtonFilterClicked = true
        invokedOnButtonFilterClickedCount += 1
    }
}
