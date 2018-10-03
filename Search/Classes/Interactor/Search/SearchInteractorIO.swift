//
//  SearchInteractorIO.swift
//  Search
//
//  Created by Hendy Christianto on 02/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import Foundation

protocol SearchInteractorInput: class {
    func requestSearch(withFilter filter: SearchFilter, start: Int, num: Int)
}

protocol SearchInteractorOutput: class {
    func foundSearchResult(results: [ProductItem], nextPage: Int)

    func foundApiError(error: ApiError)
}
