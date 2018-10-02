//
//  SearchViewController.swift
//  Search
//
//  Created by Hendy Christianto on 02/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, SearchView {
    var presenter: SearchEventHandler?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Search View
    func showSearchResults(searchResults: [ProductItem], nextPage: Int) {
    }
}
