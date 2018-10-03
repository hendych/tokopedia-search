//
//  MockSearchFilterView.swift
//  SearchTests
//
//  Created by Hendy Christianto on 03/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import Foundation
@testable import Search

class MockSearchFilterView: SearchFilterViewController {
    var invokedDismiss = false
    var invokedDismissCount = 0
    var invokedDismissParameters: (Bool)?
    var invokedDismissParametersList = [(Bool)]()
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        invokedDismiss = true
        invokedDismissCount += 1
        invokedDismissParameters = (flag)
        invokedDismissParametersList.append((flag))
    }
}
