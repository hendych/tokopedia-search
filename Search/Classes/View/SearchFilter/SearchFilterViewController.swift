//
//  SearchFilterViewController.swift
//  Search
//
//  Created by Hendy Christianto on 03/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import UIKit
import NMRangeSlider

private struct Constants {
    static let trackSliderSize: CGSize = CGSize(width: UIScreen.main.bounds.width - 20,
                                                height: 4)
    static let minSliderValue: Float = 10000
    static let maxSliderValue: Float = 1000000
    static let defaultUpperSliderValue: Float = 800000
    static let sliderStep: Float = 10
    static let padding: CGFloat = 10
    static let defaultOriginYShopType: CGFloat = 40
}

protocol SearchFilterViewDelegate: class {
    func searchFilterDidApply(newFilter filter: SearchFilter)
}

class SearchFilterViewController: UIViewController, SearchFilterView {
    weak var delegate: SearchFilterViewDelegate?
    var presenter: SearchFilterEventHandler?

    @IBOutlet var buttonClose: UIBarButtonItem!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var labelMinPrice: UILabel!
    @IBOutlet weak var labelMaxPrice: UILabel!
    @IBOutlet weak var slider: NMRangeSlider!
    @IBOutlet weak var switchWholesale: UISwitch!
    @IBOutlet weak var buttonApply: UIButton!
    @IBOutlet weak var shopTypeContainer: UIView!

    // MARK: - Initializer
    init() {
        super.init(nibName: "SearchFilterViewController", bundle: nil)

        loadViewIfNeeded()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    private func configureUI() {
        // Close Button
        self.navigationItem.leftBarButtonItem = buttonClose

        // Navigation Title
        navigationItem.title = "Filter"

        // Configure slider
        slider.lowerHandleImageNormal = UIImage(named: "ic_thumb")
        slider.upperHandleImageNormal = UIImage(named: "ic_thumb")
        slider.trackImage = UIImage.backgroundImage(withColor: .lightGreen,
                                                    size: Constants.trackSliderSize)
        slider.trackBackgroundImage = UIImage.backgroundImage(withColor: .thinGray,
                                                              size: Constants.trackSliderSize)
        slider.minimumValue = Constants.minSliderValue
        slider.maximumValue = Constants.maxSliderValue
        slider.upperValue = Constants.defaultUpperSliderValue
        slider.lowerValue = Constants.minSliderValue
        slider.stepValue = Constants.sliderStep

        // Button Apply
        buttonApply.setBackgroundImage(UIImage.backgroundImage(withColor: .lightGreen),
                                       for: .normal)

        // Set initial price
        onSliderValueChanged(slider)
    }

    // MARK: - SearchFilterView
    func addShopType(shopType: ShopType) {
        let circularView = CircularLabelView(text: shopType.rawValue)

        shopTypeContainer.addSubview(circularView)

        var originX = Constants.padding
        var originY = Constants.defaultOriginYShopType
        if let lastView = shopTypeContainer.subviews.last {
            // There is existing view, get the view origin and width
            originX = lastView.frame.origin.x + lastView.frame.size.width
                + Constants.padding

            let visibleHorizontalScreen = UIScreen.main.bounds.width - Constants.padding
            let circularHorizontalLocation = circularView.frame.origin.x
                + circularView.frame.size.width

            if circularHorizontalLocation > visibleHorizontalScreen {
                originY = lastView.frame.origin.y + lastView.frame.size.height
                    + Constants.padding
            }
        }

        circularView.frame.origin = CGPoint(x: originX, y: originY)
    }

    // MARK: - Action
    @IBAction func onButtonCloseClicked() {
        presenter?.onButtonCloseClicked()
    }

    @IBAction func onSliderValueChanged(_ sender: NMRangeSlider) {
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = "."
        numberFormatter.numberStyle = .decimal

        let minInt = Int(sender.lowerValue)
        let maxInt = Int(sender.upperValue)
        let minNumberString = numberFormatter.string(from: NSNumber(value: minInt)) ?? ""
        let maxNumberString = numberFormatter.string(from: NSNumber(value: maxInt)) ?? ""

        labelMinPrice.text = "Rp \(minNumberString)"
        labelMaxPrice.text = "Rp \(maxNumberString)"
    }

    @IBAction func onShopTypeClicked() {
        presenter?.onShopTypeClicked()
    }

    @IBAction func onButtonApplyClicked() {
        let searchFilter = SearchFilter(minPrice: String(format: "%.0f", slider.lowerValue),
                                        maxPrice: String(format: "%.0f", slider.upperValue),
                                        wholesale: switchWholesale.isOn,
                                        official: false, fshop: "2")

        delegate?.searchFilterDidApply(newFilter: searchFilter)
    }
}

// MARK: - ShopTypeViewDelegate
extension SearchFilterViewController: ShopTypeViewDelegate {
    func onShopTypeDidUncheck(type shopType: ShopType) {
    }

    func onShopTypeDidCheck(type shopType: ShopType) {
        addShopType(shopType: shopType)
    }
}
