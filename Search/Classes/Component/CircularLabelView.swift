//
//  CircularLabelView.swift
//  Search
//
//  Created by Hendy Christianto on 04/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import UIKit

private struct Constants {
    static let fontSize: CGFloat = 15
    static let marginHorizontal: CGFloat = 10
    static let marginLabelToButton: CGFloat = 30
    static let viewHeight: CGFloat = 46
}

class CircularLabelView: UIView {
    weak var delegate: ShopTypeViewDelegate?

    private(set) var labelTitle = UILabel()
    private(set) var buttonDelete = UIButton(type: .custom)

    let text: String

    // MARK: - Initializer
    init(text: String) {
        self.text = text

        super.init(frame: .zero)

        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Rendering
    private func initialize() {
        addSubview(labelTitle)
        addSubview(buttonDelete)

        // Configure label
        labelTitle.text = text
        labelTitle.font = UIFont.systemFont(ofSize: Constants.fontSize)
        labelTitle.textColor = .mediumGray
        labelTitle.numberOfLines = 1
        labelTitle.sizeToFit()
        labelTitle.frame.origin.x = Constants.marginHorizontal
        labelTitle.center.y = Constants.viewHeight / 2

        let originXButton = labelTitle.frame.origin.x + labelTitle.frame.size.width
            + Constants.marginLabelToButton

        // Configure button
        buttonDelete.frame = CGRect(x: originXButton,
                                    y: 0,
                                    width: Constants.viewHeight,
                                    height: Constants.viewHeight)
        buttonDelete.center.y = Constants.viewHeight / 2
        buttonDelete.setImage(UIImage(named: "ic_close"), for: .normal)
        buttonDelete.setBackgroundImage(UIImage.backgroundImage(withColor: .brokenWhite),
                                        for: .normal)
        buttonDelete.circular(withBorderColor: .thinGray)
        buttonDelete.addTarget(self,
                               action: #selector(self.onButtonDeleteClicked),
                               for: .touchUpInside)

        self.backgroundColor = .white
        self.frame.size = CGSize(width: originXButton + buttonDelete.frame.size.width,
                                 height: Constants.viewHeight)
        self.circular(withBorderColor: .thinGray)
    }

    @objc func onButtonDeleteClicked() {
        guard let shopType = ShopType(rawValue: text) else { return }

        delegate?.onShopTypeDidUncheck(type: shopType)
    }
}
