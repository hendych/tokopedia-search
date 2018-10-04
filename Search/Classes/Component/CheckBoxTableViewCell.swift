//
//  CheckBoxTableViewCell.swift
//  Search
//
//  Created by Hendy Christianto on 04/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import UIKit

class CheckBoxTableViewCell: UITableViewCell {

    @IBOutlet weak var buttonCheckbox: UIButton!
    @IBOutlet weak var labelTitle: UILabel!

    static func getHeight() -> CGFloat {
        return 56
    }

    // MARK: - Button Action
    @IBAction func buttonCheckBoxOnClick() {
        buttonCheckbox.isSelected = !buttonCheckbox.isSelected
    }
}
