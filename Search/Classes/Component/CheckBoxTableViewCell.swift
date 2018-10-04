//
//  CheckBoxTableViewCell.swift
//  Search
//
//  Created by Hendy Christianto on 04/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import UIKit

class CheckBoxTableViewCell: UITableViewCell {
    weak var delegate: ShopTypeViewDelegate?

    @IBOutlet weak var buttonCheckbox: UIButton!
    @IBOutlet weak var labelTitle: UILabel!

    static func getHeight() -> CGFloat {
        return 56
    }

    // MARK: - Button Action
    @IBAction func buttonCheckBoxOnClick() {
        buttonCheckbox.isSelected = !buttonCheckbox.isSelected

        guard let text = labelTitle.text,
            let shopType = ShopType(rawValue: text) else { return }

        if buttonCheckbox.isSelected {
            delegate?.onShopTypeDidCheck(type: shopType)
        } else {
            delegate?.onShopTypeDidUncheck(type: shopType)
        }
    }
}
