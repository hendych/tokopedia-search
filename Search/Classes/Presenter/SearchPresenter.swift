//
//  SearchPresenter.swift
//  Search
//
//  Created by Hendy Christianto on 02/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import Foundation

class SearchPresenter: SearchEventHandler, SearchInteractorOutput {
    weak var view: SearchViewController?
    let interactor: SearchInteractorInput
    let router: SearchRouter

    init(interactor: SearchInteractorInput, router: SearchRouter) {
        self.interactor = interactor
        self.router = router
    }
}
