//
//  MockSearchFilterRouter.swift
//  SearchTests
//
//  Created by Hendy Christianto on 03/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import UIKit
@testable import Search

class MockSearchFilterRouter: SearchFilterRouter {
    var invokedViewControllerGetter = false
    var invokedViewControllerGetterCount = 0
    var stubbedViewController: UINavigationController!
    override var viewController: UINavigationController {
        invokedViewControllerGetter = true
        invokedViewControllerGetterCount += 1
        return stubbedViewController
    }
    var invokedPushShopTypeViewController = false
    var invokedPushShopTypeViewControllerCount = 0
    var invokedPushShopTypeViewControllerParameters: (view: UIViewController?, animated: Bool)?
    var invokedPushShopTypeViewControllerParametersList = [(view: UIViewController?, animated: Bool)]()
    override func pushShopTypeViewController(from view: UIViewController?, animated: Bool) {
        invokedPushShopTypeViewController = true
        invokedPushShopTypeViewControllerCount += 1
        invokedPushShopTypeViewControllerParameters = (view, animated)
        invokedPushShopTypeViewControllerParametersList.append((view, animated))
    }
}
