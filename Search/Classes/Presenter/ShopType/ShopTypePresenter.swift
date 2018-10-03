//
//  ShopTypePresenter.swift
//  Search
//
//  Created by Hendy Christianto on 03/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import Foundation

class ShopTypePresenter: ShopTypeEventHandler, ShopTypeInteractorOutput {
    weak var view: ShopTypeView?
    let interactor: ShopTypeInteractorInput
    let router: ShopTypeRouter

    init(interactor: ShopTypeInteractorInput, router: ShopTypeRouter) {
        self.interactor = interactor
        self.router = router
    }
}
