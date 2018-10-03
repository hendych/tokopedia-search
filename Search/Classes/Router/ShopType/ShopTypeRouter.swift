//
//  ShopTypeRouter.swift
//  Search
//
//  Created by Hendy Christianto on 03/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import UIKit

class ShopTypeRouter: Router {

    var viewController: UIViewController {
        let view = ShopTypeViewController()
        let interactor = ShopTypeInteractor()
        let presenter = ShopTypePresenter(interactor: interactor, router: self)

        presenter.view = view
        view.presenter = presenter
        interactor.output = presenter

        return view
    }
}
