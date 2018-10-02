//
//  UICollectionViewCellExtension.swift
//  Search
//
//  Created by Hendy Christianto on 03/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    static func identifier() -> String {
        return String(describing: self)
    }
}
