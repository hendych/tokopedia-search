//
//  SearchInteractor.swift
//  Search
//
//  Created by Hendy Christianto on 02/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import Foundation

class SearchInteractor: SearchInteractorInput {
    weak var output: SearchInteractorOutput?

    private let service: SearchService

    init(service: SearchService = SearchService()) {
        self.service = service
    }

    // MARK: - SearchInteractorInput
    func requestSearch(withFilter filter: SearchFilter, start: Int, num: Int) {
        service.requestSearch(filter, start: start, rows: num) { [weak self] (result, error) in
            if let error = error {
                self?.output?.foundApiError(error: error)

                return
            }

            var productItems = [ProductItem]()

            guard let jsonObjects = result?["data"] as? [[String: Any]] else {
                self?.output?.foundSearchResult(results: productItems, nextPage: 0)

                return
            }

            for json in jsonObjects {
                if let productItem = ProductItem(json: json) {
                    productItems.append(productItem)
                }
            }

            self?.output?.foundSearchResult(results: productItems, nextPage: start + num)
        }
    }
}
