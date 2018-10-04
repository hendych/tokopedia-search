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
