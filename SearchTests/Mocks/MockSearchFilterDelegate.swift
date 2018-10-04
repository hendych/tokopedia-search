//
//  MockSearchFilterDelegate.swift
//  SearchTests
//
//  Created by Hendy Christianto on 04/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import Foundation
@testable import Search

class MockSearchFilterDelegate: SearchFilterViewDelegate {
    var invokedSearchFilterDidApply = false
    var invokedSearchFilterDidApplyCount = 0
    var invokedSearchFilterDidApplyParameters: (filter: SearchFilter, Void)?
    var invokedSearchFilterDidApplyParametersList = [(filter: SearchFilter, Void)]()
    func searchFilterDidApply(newFilter filter: SearchFilter) {
        invokedSearchFilterDidApply = true
        invokedSearchFilterDidApplyCount += 1
        invokedSearchFilterDidApplyParameters = (filter, ())
        invokedSearchFilterDidApplyParametersList.append((filter, ()))
    }
}
