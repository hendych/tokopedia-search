//
//  MockSearchRouter.swift
//  SearchTests
//
//  Created by Hendy Christianto on 02/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import UIKit
@testable import Search

class MockSearchRouter: SearchRouter {
    var invokedViewControllerGetter = false
    var invokedViewControllerGetterCount = 0
    var stubbedViewController: UINavigationController!
    override var viewController: UINavigationController {
        invokedViewControllerGetter = true
        invokedViewControllerGetterCount += 1
        return stubbedViewController
    }
    var invokedPresentSearchFilterView = false
    var invokedPresentSearchFilterViewCount = 0
    var invokedPresentSearchFilterViewParameters: (view: SearchViewController?, animated: Bool)?
    var invokedPresentSearchFilterViewParametersList = [(view: SearchViewController?, animated: Bool)]()
    override func presentSearchFilterView(onView view: SearchViewController?, animated: Bool) {
        invokedPresentSearchFilterView = true
        invokedPresentSearchFilterViewCount += 1
        invokedPresentSearchFilterViewParameters = (view, animated)
        invokedPresentSearchFilterViewParametersList.append((view, animated))
    }
}
