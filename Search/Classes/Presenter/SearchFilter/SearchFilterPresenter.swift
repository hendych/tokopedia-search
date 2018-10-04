//
//  SearchFilterPresenter.swift
//  Search
//
//  Created by Hendy Christianto on 03/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import UIKit

class SearchFilterPresenter: SearchFilterEventHandler, SearchFilterInteractorOutput {
    weak var view: SearchFilterView?
    let interactor: SearchFilterInteractorInput
    let router: SearchFilterRouter

    init(interactor: SearchFilterInteractorInput, router: SearchFilterRouter) {
        self.interactor = interactor
        self.router = router
    }

    // MARK: - SearchFilterEventHandler
    func onButtonCloseClicked() {
        (view as? UIViewController)?.dismiss(animated: true, completion: nil)
    }

    func onShopTypeClicked() {
        router.pushShopTypeViewController(from: (view as? SearchFilterViewController),
                                          animated: true)
    }
}
