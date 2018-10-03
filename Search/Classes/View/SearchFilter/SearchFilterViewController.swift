//
//  SearchFilterViewController.swift
//  Search
//
//  Created by Hendy Christianto on 03/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import UIKit
import NMRangeSlider

class SearchFilterViewController: UIViewController, SearchFilterView {
    var presenter: SearchFilterEventHandler?

    @IBOutlet var buttonClose: UIBarButtonItem!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerSlider: UIView!
    @IBOutlet weak var labelMinPrice: UILabel!
    @IBOutlet weak var labelMaxPrice: UILabel!

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
        let slider = NMRangeSlider(frame: containerSlider.bounds)
        slider.lowerHandleImageNormal = UIImage(named: "ic_thumb")
        slider.upperHandleImageNormal = UIImage(named: "ic_thumb")
        containerSlider.addSubview(slider)
    }

    // MARK: - Button Action
    @IBAction func onButtonCloseClicked() {
        presenter?.onButtonCloseClicked()
    }
}
