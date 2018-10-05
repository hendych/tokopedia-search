//
//  SearchFilterRouter.swift
//  Search
//
//  Created by Hendy Christianto on 03/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import UIKit

class SearchFilterRouter: Router {

    var viewController: UINavigationController {
        let view = SearchFilterViewController(initialSearchFilter: initialSearchFilter)
        let interactor = SearchFilterInteractor()
        let presenter = SearchFilterPresenter(interactor: interactor, router: self)
        let navigationController = UINavigationController(rootViewController: view)

        view.delegate = delegate

        presenter.view = view
        view.presenter = presenter
        interactor.output = presenter

        return navigationController
    }

    private weak var delegate: SearchFilterViewDelegate?
    private var initialSearchFilter: SearchFilter?

    init(initialSearchFilter: SearchFilter?, delegate: SearchFilterViewDelegate?) {
        self.delegate = delegate
        self.initialSearchFilter = initialSearchFilter
    }

    deinit {
        debugPrint("\(String(describing: self)) deinit")
    }

    // MARK: - Navigations
    func pushShopTypeViewController(from view: SearchFilterViewController?,
                                    initialShopType: [ShopType]?,
                                    animated: Bool) {
        let shopTypeRouter = ShopTypeRouter(initialShopType: initialShopType,
                                            delegate: view)

        view?.navigationController?.pushViewController(shopTypeRouter.viewController,
                                                       animated: animated)
    }
}
