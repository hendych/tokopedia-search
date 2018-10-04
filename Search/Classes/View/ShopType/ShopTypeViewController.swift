//
//  ShopTypeViewController.swift
//  Search
//
//  Created by Hendy Christianto on 03/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import UIKit

class ShopTypeViewController: UIViewController, ShopTypeView {
    var presenter: ShopTypeEventHandler?

    @IBOutlet weak var tableView: UITableView!

    let shopTypeData: [[String: Bool]] = [
        ["Gold Merchant": false],
        ["Official Store": false]
    ]

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
        return shopTypeData.count
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
            cell.labelTitle.text = shopTypeData[indexPath.row].keys.first
        default:
            break
        }
    }
}
