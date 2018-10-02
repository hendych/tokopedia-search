//
//  MockSearchInteractorOutput.swift
//  SearchTests
//
//  Created by Hendy Christianto on 02/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import Foundation
@testable import Search

class MockSearchInteractorOutput: SearchInteractorOutput {
    var invokedFoundSearchResult = false
    var invokedFoundSearchResultCount = 0
    var invokedFoundSearchResultParameters: (results: [ProductItem], nextPage: Int)?
    var invokedFoundSearchResultParametersList = [(results: [ProductItem], nextPage: Int)]()
    func foundSearchResult(results: [ProductItem], nextPage: Int) {
        invokedFoundSearchResult = true
        invokedFoundSearchResultCount += 1
        invokedFoundSearchResultParameters = (results, nextPage)
        invokedFoundSearchResultParametersList.append((results, nextPage))
    }
    var invokedFoundApiError = false
    var invokedFoundApiErrorCount = 0
    var invokedFoundApiErrorParameters: (error: ApiError, Void)?
    var invokedFoundApiErrorParametersList = [(error: ApiError, Void)]()
    func foundApiError(error: ApiError) {
        invokedFoundApiError = true
        invokedFoundApiErrorCount += 1
        invokedFoundApiErrorParameters = (error, ())
        invokedFoundApiErrorParametersList.append((error, ()))
    }
}
