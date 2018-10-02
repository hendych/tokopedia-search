//
//  SearchViewController.swift
//  Search
//
//  Created by Hendy Christianto on 02/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import UIKit

private struct Constants {
    static let numOfItemPerPage = 10
}

class SearchViewController: UIViewController, SearchView {
    var presenter: SearchEventHandler?

    private var filter = SearchFilter()
    private var start = 0

    // MARK: - Initializer
    init() {
        super.init(nibName: "SearchViewController", bundle: nil)

        loadViewIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter?.onRequestSearch(withFilter: filter, start: 0, num: Constants.numOfItemPerPage)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Search View
    func showSearchResults(searchResults: [ProductItem], nextPage: Int) {
    }
}
