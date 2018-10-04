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
        let view = ShopTypeViewController(initialShopType: initialShopType)
        let interactor = ShopTypeInteractor()
        let presenter = ShopTypePresenter(interactor: interactor, router: self)

        view.delegate = delegate

        presenter.view = view
        view.presenter = presenter
        interactor.output = presenter

        return view
    }

    private weak var delegate: ShopTypeViewDelegate?
    private var initialShopType: [ShopType]?

    init(initialShopType: [ShopType]?, delegate: ShopTypeViewDelegate?) {
        self.delegate = delegate
        self.initialShopType = initialShopType
    }
}
