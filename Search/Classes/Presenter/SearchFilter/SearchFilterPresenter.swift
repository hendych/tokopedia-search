//
//  SearchFilterPresenter.swift
//  Search
//
//  Created by Hendy Christianto on 03/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import Foundation

class SearchFilterPresenter: SearchFilterEventHandler, SearchFilterInteractorOutput {
    weak var view: SearchFilterView?
    let interactor: SearchFilterInteractorInput
    let router: SearchFilterRouter

    init(interactor: SearchFilterInteractorInput, router: SearchFilterRouter) {
        self.interactor = interactor
        self.router = router
    }
}
