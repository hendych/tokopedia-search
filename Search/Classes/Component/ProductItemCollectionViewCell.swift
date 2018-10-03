//
//  ProductItemCollectionViewCell.swift
//  Search
//
//  Created by Hendy Christianto on 03/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import UIKit
import AlamofireImage

private struct Constants {
    static let paddingBottomCell: CGFloat = 87.5
}

class ProductItemCollectionViewCell: UICollectionViewCell {

    var productItem: ProductItem? {
        didSet {
            renderView()
        }
    }

    @IBOutlet weak var imageViewProduct: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPrice: UILabel!

    // MARK: - Static Functions
    static func getSize(forInterItemSpacing: CGFloat) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 2.0 - forInterItemSpacing / 2,
                      height: UIScreen.main.bounds.width / 2.0 + Constants.paddingBottomCell)
    }

    // MARK: - Render View
    private func renderView() {
        guard let productItem = productItem else { return }

        imageViewProduct.image = UIImage.backgroundImage(withColor: .lightGray)
        imageViewProduct.af_cancelImageRequest()

        if let url = URL(string: productItem.imageUri) {
            imageViewProduct.af_setImage(withURL: url)
        }

        labelName.text = productItem.name
        labelPrice.text = productItem.price
    }
}
