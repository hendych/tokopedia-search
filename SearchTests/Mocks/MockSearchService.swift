//
//  MockSearchService.swift
//  SearchTests
//
//  Created by Hendy Christianto on 02/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import Foundation
@testable import Search

class MockSearchService: SearchService {
    var invokedRequestSearch = false
    var invokedRequestSearchCount = 0
    var invokedRequestSearchParameters: (filter: SearchFilter, start: Int, rows: Int)?
    var invokedRequestSearchParametersList = [(filter: SearchFilter, start: Int, rows: Int)]()
    var stubbedRequestSearchCompletionResult: ([String: Any]?, ApiError?)?
    override func requestSearch(_ filter: SearchFilter, start: Int, rows: Int,
    completion: @escaping Completion) {
        invokedRequestSearch = true
        invokedRequestSearchCount += 1
        invokedRequestSearchParameters = (filter, start, rows)
        invokedRequestSearchParametersList.append((filter, start, rows))
        if let result = stubbedRequestSearchCompletionResult {
            completion(result.0, result.1)
        }
    }
}
