//
//  SearchPresenter.swift
//  Search
//
//  Created by Hendy Christianto on 02/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import Foundation

class SearchPresenter: SearchEventHandler, SearchInteractorOutput {
    weak var view: SearchView?
    let interactor: SearchInteractorInput
    let router: SearchRouter

    init(interactor: SearchInteractorInput, router: SearchRouter) {
        self.interactor = interactor
        self.router = router
    }

    // MARK: - SearchInteractorOutput
    func foundSearchResult(results: [ProductItem], nextPage: Int) {
        view?.showSearchResults(searchResults: results, nextPage: nextPage)
    }

    func foundApiError(error: ApiError) {
    }
}
