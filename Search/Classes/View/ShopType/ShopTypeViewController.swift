//
//  ShopTypeViewController.swift
//  Search
//
//  Created by Hendy Christianto on 03/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import UIKit

protocol ShopTypeViewDelegate: class {
    func onShopTypeDidCheck(type shopType: ShopType)

    func onShopTypeDidUncheck(type shopType: ShopType)
}

class ShopTypeViewController: UIViewController, ShopTypeView {
    weak var delegate: ShopTypeViewDelegate?
    var presenter: ShopTypeEventHandler?

    @IBOutlet weak var tableView: UITableView!

    let shopTypeData: [ShopType: Bool]

    init(initialShopType: [ShopType]?) {
        var defaultShopTypeData: [ShopType: Bool] = [
            .goldMerchant: false,
            .officialStore: false
        ]

        if let initialShopType = initialShopType {
            for shopType in initialShopType {
                defaultShopTypeData[shopType] = true
            }
        }

        self.shopTypeData = defaultShopTypeData

        super.init(nibName: "ShopTypeViewController", bundle: nil)

        loadViewIfNeeded()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        debugPrint("\(String(describing: self)) Dealloc")
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    private func configureUI() {
        tableView.register(UINib(nibName: CheckBoxTableViewCell.identifier(), bundle: nil),
                           forCellReuseIdentifier: CheckBoxTableViewCell.identifier())

        // Navigation Title
        navigationItem.title = "Shop Type"
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension ShopTypeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Array(shopTypeData.keys).count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView
            .dequeueReusableCell(withIdentifier: CheckBoxTableViewCell.identifier()) {
            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CheckBoxTableViewCell.getHeight()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        switch cell {
        case is CheckBoxTableViewCell:
            guard let cell = cell as? CheckBoxTableViewCell else { return }
            let shopType = Array(shopTypeData.keys)[indexPath.row]

            cell.delegate = delegate
            cell.buttonCheckbox.isSelected = shopTypeData[shopType] ?? false
            cell.labelTitle.text = shopType.rawValue
        default:
            break
        }
    }
}
