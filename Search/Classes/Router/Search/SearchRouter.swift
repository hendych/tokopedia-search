//
//  SearchRouter.swift
//  Search
//
//  Created by Hendy Christianto on 02/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import UIKit

class SearchRouter: Router {

    var viewController: UINavigationController {
        let view = SearchViewController()
        let interactor = SearchInteractor()
        let presenter = SearchPresenter(interactor: interactor, router: self)
        let navigationController = UINavigationController(rootViewController: view)

        presenter.view = view
        view.presenter = presenter
        interactor.output = presenter

        return navigationController
    }

    func presentSearchFilterView(onView view: UIViewController?) {
        let searchFilterRouter = SearchFilterRouter()

        view?.present(searchFilterRouter.viewController, animated: true, completion: nil)
    }
}
