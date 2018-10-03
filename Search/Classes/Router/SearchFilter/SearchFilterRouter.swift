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
        let view = SearchFilterViewController()
        let interactor = SearchFilterInteractor()
        let presenter = SearchFilterPresenter(interactor: interactor, router: self)
        let navigationController = UINavigationController(rootViewController: view)

        presenter.view = view
        view.presenter = presenter
        interactor.output = presenter

        return navigationController
    }
}
