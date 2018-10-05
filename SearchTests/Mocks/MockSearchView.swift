//
//  MockSearchView.swift
//  SearchTests
//
//  Created by Hendy Christianto on 02/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import UIKit
@testable import Search

class MockSearchView: SearchViewController {
    var invokedShowSearchResults = false
    var invokedShowSearchResultsCount = 0
    var invokedShowSearchResultsParameters: (searchResults: [ProductItem], nextPage: Int)?
    var invokedShowSearchResultsParametersList = [(searchResults: [ProductItem], nextPage: Int)]()
    override func showSearchResults(searchResults: [ProductItem], nextPage: Int) {
        invokedShowSearchResults = true
        invokedShowSearchResultsCount += 1
        invokedShowSearchResultsParameters = (searchResults, nextPage)
        invokedShowSearchResultsParametersList.append((searchResults, nextPage))
    }
    var invokedShowApiError = false
    var invokedShowApiErrorCount = 0
    var invokedShowApiErrorParameters: (apiError: ApiError, Void)?
    var invokedShowApiErrorParametersList = [(apiError: ApiError, Void)]()
    override func showApiError(apiError: ApiError) {
        invokedShowApiError = true
        invokedShowApiErrorCount += 1
        invokedShowApiErrorParameters = (apiError, ())
        invokedShowApiErrorParametersList.append((apiError, ()))
    }
    var invokedOnButtonFilterClicked = false
    var invokedOnButtonFilterClickedCount = 0
    override func onButtonFilterClicked() {
        invokedOnButtonFilterClicked = true
        invokedOnButtonFilterClickedCount += 1
    }
    var invokedPresent = false
    var invokedPresentCount = 0
    var invokedPresentParameters: (viewControllerToPresent: UIViewController, animated: Bool)?
    var invokedPresentParametersList = [(viewControllerToPresent: UIViewController, animated: Bool)]()
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        invokedPresent = true
        invokedPresentCount += 1
        invokedPresentParameters = (viewControllerToPresent, flag)
        invokedPresentParametersList.append((viewControllerToPresent, flag))
    }
}
