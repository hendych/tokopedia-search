//
//  UITableViewCellExtension.swift
//  Search
//
//  Created by Hendy Christianto on 04/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static func identifier() -> String {
        return String(describing: self)
    }
}
