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
    static let sliderStep: Float = 10
    static let padding: CGFloat = 10
    static let defaultOriginYShopType: CGFloat = 40
    static let defaultShopTypeContainerHeight: CGFloat = 100
}

protocol SearchFilterViewDelegate: class {
    func searchFilterDidApply(newFilter filter: SearchFilter)
}

class SearchFilterViewController: UIViewController, SearchFilterView {
    weak var delegate: SearchFilterViewDelegate?
    var presenter: SearchFilterEventHandler?

    @IBOutlet var buttonClose: UIBarButtonItem!
    @IBOutlet var buttonReset: UIBarButtonItem!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var labelMinPrice: UILabel!
    @IBOutlet weak var labelMaxPrice: UILabel!
    @IBOutlet weak var slider: NMRangeSlider!
    @IBOutlet weak var switchWholesale: UISwitch!
    @IBOutlet weak var buttonApply: UIButton!
    @IBOutlet weak var shopTypeContainer: UIView!
    @IBOutlet weak var shopTypeContainerHeight: NSLayoutConstraint!

    private(set) var initialSearchFilter: SearchFilter

    // MARK: - Initializer
    init(initialSearchFilter: SearchFilter?) {
        self.initialSearchFilter = initialSearchFilter ?? SearchFilter()

        super.init(nibName: "SearchFilterViewController", bundle: nil)

        loadViewIfNeeded()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        debugPrint("\(String(describing: self)) deinit")
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    private func configureUI() {
        // Close Button
        self.navigationItem.leftBarButtonItem = buttonClose

        // Reset Button
        self.navigationItem.rightBarButtonItem = buttonReset

        // Navigation Title
        navigationItem.title = "Filter"

        // Button Apply
        buttonApply.setBackgroundImage(UIImage.backgroundImage(withColor: .lightGreen),
                                       for: .normal)

        configureUIValues()
    }

    private func configureUIValues() {
        // Configure slider
        slider.lowerHandleImageNormal = UIImage(named: "ic_thumb")
        slider.upperHandleImageNormal = UIImage(named: "ic_thumb")
        slider.trackImage = UIImage.backgroundImage(withColor: .lightGreen,
                                                    size: Constants.trackSliderSize)
        slider.trackBackgroundImage = UIImage.backgroundImage(withColor: .thinGray,
                                                              size: Constants.trackSliderSize)
        slider.minimumValue = Constants.minSliderValue
        slider.maximumValue = Constants.maxSliderValue
        slider.upperValue = Float(initialSearchFilter.maxPrice) ?? 0
        slider.lowerValue = Float(initialSearchFilter.minPrice) ?? 0
        slider.stepValue = Constants.sliderStep

        // Configure wholesale
        switchWholesale.isOn = initialSearchFilter.wholesale

        // Configure shop type
        if initialSearchFilter.fshop == SearchFilter.goldSeller {
            addShopType(shopType: .goldMerchant)
        }

        if initialSearchFilter.official {
            addShopType(shopType: .officialStore)
        }

        // Set initial price
        onSliderValueChanged(slider)
    }

    // MARK: - SearchFilterView
    func addShopType(shopType: ShopType) {
        let circularView = CircularLabelView(text: shopType.rawValue)
        circularView.delegate = self

        var originX = Constants.padding
        var originY = Constants.defaultOriginYShopType

        var lastCircularView: CircularLabelView?

        for subview in shopTypeContainer.subviews {
            if let circular = subview as? CircularLabelView {
                lastCircularView = circular
            }
        }

        if let lastView = lastCircularView {
            // There is existing view, get the view origin and width
            originX = lastView.frame.origin.x + lastView.frame.size.width
                + Constants.padding

            let visibleHorizontalScreen = UIScreen.main.bounds.width - Constants.padding
            let circularHorizontalLocation = originX + circularView.frame.size.width

            if circularHorizontalLocation > visibleHorizontalScreen {
                originX = Constants.padding
                originY = lastView.frame.origin.y + lastView.frame.size.height
                    + Constants.padding

                shopTypeContainerHeight.constant += circularView.frame.size.height
                    + Constants.padding
            }
        }

        shopTypeContainer.addSubview(circularView)
        circularView.frame.origin = CGPoint(x: originX, y: originY)
    }

    func removeShopType(shopType: ShopType) {
        for subview in shopTypeContainer.subviews {
            guard let circularLabelView = subview as? CircularLabelView else {
                continue
            }

            if circularLabelView.text == shopType.rawValue {
                // Remove
                circularLabelView.removeFromSuperview()

                break
            }
        }

        // Reassign views frame
        let visibleHorizontalScreen = UIScreen.main.bounds.width - Constants.padding
        var previousOriginX = Constants.padding
        var previousOriginY = Constants.defaultOriginYShopType
        for subview in shopTypeContainer.subviews {
            guard let circularLabelView = subview as? CircularLabelView else {
                continue
            }

            circularLabelView.frame.origin.x = previousOriginX
            circularLabelView.frame.origin.y = previousOriginY

            shopTypeContainerHeight.constant = previousOriginY
                + circularLabelView.frame.size.height + Constants.padding

            previousOriginX += circularLabelView.frame.size.width

            if previousOriginX > visibleHorizontalScreen {
                previousOriginY = circularLabelView.frame.origin.y
                    + circularLabelView.frame.size.height
                    + Constants.padding
                previousOriginX = Constants.padding
            }
        }
    }

    func getShopTypes() -> [ShopType]? {
        var shopTypes: [ShopType]?
        for subview in shopTypeContainer.subviews {
            if let circularView = subview as? CircularLabelView {
                if shopTypes == nil {
                    shopTypes = [ShopType]()
                }

                if let shopType = ShopType(rawValue: circularView.text) {
                    shopTypes?.append(shopType)
                }
            }
        }

        return shopTypes
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
        presenter?.onShopTypeClicked(initialShopType: getShopTypes())
    }

    @IBAction func onButtonApplyClicked() {
        var official = false
        var fshop = ""
        for shopType in getShopTypes() ?? [ShopType]() {
            if shopType == .goldMerchant {
                fshop = SearchFilter.goldSeller
            } else if shopType == .officialStore {
                official = true
            }
        }

        let searchFilter = SearchFilter(minPrice: String(format: "%.0f", slider.lowerValue),
                                        maxPrice: String(format: "%.0f", slider.upperValue),
                                        wholesale: switchWholesale.isOn,
                                        official: official, fshop: fshop)

        delegate?.searchFilterDidApply(newFilter: searchFilter)
    }

    @IBAction func onButtonResetClicked() {
        // Reset to default
        self.initialSearchFilter = SearchFilter()

        removeShopType(shopType: .goldMerchant)
        removeShopType(shopType: .officialStore)

        configureUIValues()
    }
}

// MARK: - ShopTypeViewDelegate
extension SearchFilterViewController: ShopTypeViewDelegate {
    func onShopTypeDidUncheck(type shopType: ShopType) {
        removeShopType(shopType: shopType)
    }

    func onShopTypeDidCheck(type shopType: ShopType) {
        addShopType(shopType: shopType)
    }
}
