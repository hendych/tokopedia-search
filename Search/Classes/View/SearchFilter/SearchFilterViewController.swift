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
    static let sliderStep: Float = 40000
}

class SearchFilterViewController: UIViewController, SearchFilterView {
    var presenter: SearchFilterEventHandler?

    @IBOutlet var buttonClose: UIBarButtonItem!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var labelMinPrice: UILabel!
    @IBOutlet weak var labelMaxPrice: UILabel!
    @IBOutlet weak var slider: NMRangeSlider!

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

        // Configure slider
        slider.lowerHandleImageNormal = UIImage(named: "ic_thumb")
        slider.upperHandleImageNormal = UIImage(named: "ic_thumb")
        slider.trackImage = UIImage.backgroundImage(withColor: .lightGreen,
                                                    size: Constants.trackSliderSize)
        slider.trackBackgroundImage = UIImage.backgroundImage(withColor: .thinGray,
                                                              size: Constants.trackSliderSize)
        slider.minimumValue = Constants.minSliderValue
        slider.maximumValue = Constants.maxSliderValue
        slider.stepValue = Constants.sliderStep
        slider.upperValue = Constants.defaultUpperSliderValue
    }

    // MARK: - Action
    @IBAction func onButtonCloseClicked() {
        presenter?.onButtonCloseClicked()
    }

    @IBAction func onSliderValueChanged() {
    }
}
