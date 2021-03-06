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
    static let percentScrollLoadMore: CGFloat = 0.8
}

class SearchViewController: UIViewController, SearchView {
    var presenter: SearchEventHandler?

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var buttonFilter: UIButton!

    private(set) var filter = SearchFilter()
    private(set) var start = 0
    private(set) var searchResults = [ProductItem]()
    private(set) var isLoading = false
    private(set) var alert: UIAlertController?

    // MARK: - Initializer
    init() {
        super.init(nibName: "SearchViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()

        isLoading = true
        presenter?.onRequestSearch(withFilter: filter, start: 0, num: Constants.numOfItemPerPage)
    }

    private func configureUI() {
        collectionView.register(UINib(nibName: ProductItemCollectionViewCell.identifier(),
                                      bundle: nil),
                                forCellWithReuseIdentifier: ProductItemCollectionViewCell.identifier())

        // Add title
        navigationItem.title = "Search"

        // Button filter
        buttonFilter.setBackgroundImage(UIImage.backgroundImage(withColor: .lightGreen),
                                        for: .normal)
    }

    // MARK: - Search View
    func showSearchResults(searchResults: [ProductItem], nextPage: Int) {
        collectionView.performBatchUpdates({
            var indexPaths = [IndexPath]()
            var indexResult = 0
            for row in start..<nextPage {
                self.searchResults.append(searchResults[indexResult])

                indexPaths.append(IndexPath(row: row, section: 0))

                indexResult += 1
            }

            collectionView.insertItems(at: indexPaths)
        }, completion: nil)

        self.isLoading = false
        self.start = nextPage
    }

    func showApiError(apiError: ApiError) {
        let alertView = UIAlertController(title: nil,
                                          message: apiError.message,
                                          preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        alert = alertView

        present(alertView, animated: true, completion: nil)
    }

    // MARK: - Button Action
    @IBAction func onButtonFilterClicked() {
        presenter?.onButtonFilterClicked(withFilter: filter)
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
        let percentScrolled = (scrollView.contentOffset.y + UIScreen.main.bounds.size.height)
            / scrollView.contentSize.height
        if isLoading == false, percentScrolled >= Constants.percentScrollLoadMore {
            isLoading = true
            presenter?.onRequestSearch(withFilter: filter,
                                       start: start,
                                       num: Constants.numOfItemPerPage)
        }
    }
}

// MARK: - SearchFilterViewDelegate
extension SearchViewController: SearchFilterViewDelegate {
    func searchFilterDidApply(newFilter filter: SearchFilter) {
        self.filter = filter

        presentedViewController?.dismiss(animated: true, completion: nil)

        searchResults = [ProductItem]()
        start = 0

        collectionView.reloadData()

        isLoading = true
        presenter?.onRequestSearch(withFilter: filter,
                                   start: start,
                                   num: Constants.numOfItemPerPage)
    }
}
