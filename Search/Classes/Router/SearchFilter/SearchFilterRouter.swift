//
//  SearchFilterRouter.swift
//  Search
//
//  Created by Hendy Christianto on 03/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import UIKit

class SearchFilterRouter: Router {

    var viewController: UIViewController {
        let view = SearchFilterViewController()
        let interactor = SearchFilterInteractor()
        let presenter = SearchFilterPresenter(interactor: interactor, router: self)

        presenter.view = view
        view.presenter = presenter
        interactor.output = presenter

        return view
    }
}
