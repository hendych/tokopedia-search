//
//  UIViewExtension.swift
//  Search
//
//  Created by Hendy Christianto on 04/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import UIKit

extension UIView {
    func circular(withBorderColor borderColor: UIColor?) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height / 2

        if let borderColor = borderColor {
            self.layer.borderWidth = 1
            self.layer.borderColor = borderColor.cgColor
        }
    }
}
