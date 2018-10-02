//
//  MockSearchInteractorInput.swift
//  SearchTests
//
//  Created by Hendy Christianto on 02/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import Foundation
@testable import Search

class MockSearchInteractorInput: SearchInteractorInput {
    var invokedRequestSearch = false
    var invokedRequestSearchCount = 0
    var invokedRequestSearchParameters: (filter: SearchFilter, start: Int, num: Int)?
    var invokedRequestSearchParametersList = [(filter: SearchFilter, start: Int, num: Int)]()
    func requestSearch(withFilter filter: SearchFilter, start: Int, num: Int) {
        invokedRequestSearch = true
        invokedRequestSearchCount += 1
        invokedRequestSearchParameters = (filter, start, num)
        invokedRequestSearchParametersList.append((filter, start, num))
    }
}
