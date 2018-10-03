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
    static let paddingItem: CGFloat = 1
}

class SearchViewController: UIViewController, SearchView {
    var presenter: SearchEventHandler?

    @IBOutlet weak var collectionView: UICollectionView!

    private(set) var filter = SearchFilter()
    private(set) var start = 0
    private(set) var searchResults = [ProductItem]()

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

        configureUI()
    }

    private func configureUI() {
        collectionView.register(UINib(nibName: ProductItemCollectionViewCell.identifier(),
                                      bundle: nil),
                                forCellWithReuseIdentifier: ProductItemCollectionViewCell.identifier())
    }

    // MARK: - Search View
    func showSearchResults(searchResults: [ProductItem], nextPage: Int) {
        self.searchResults.append(contentsOf: searchResults)
        self.start = nextPage

        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate
extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.searchResults.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return ProductItemCollectionViewCell.getSize(forInterItemSpacing: Constants.paddingItem)
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView
            .dequeueReusableCell(withReuseIdentifier: ProductItemCollectionViewCell.identifier(),
                                 for: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        switch cell {
        case is ProductItemCollectionViewCell:
            guard let cell = cell as? ProductItemCollectionViewCell else { return }

            cell.productItem = searchResults[indexPath.row]
        default:
            break
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.paddingItem
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.paddingItem
    }

    // Load more event
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
}
