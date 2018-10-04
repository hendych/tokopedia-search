//
//  SearchFilterViewTests.swift
//  SearchTests
//
//  Created by Hendy Christianto on 03/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import XCTest
import NMRangeSlider
@testable import Search

class SearchFilterViewTests: XCTestCase {

    var mockEventHandler: MockSearchFilterEventHandler?
    var view = SearchFilterViewController()

    override func setUp() {
        mockEventHandler = MockSearchFilterEventHandler()

        view.presenter = mockEventHandler
    }

    func testActionOnButtonCloseClicked() {
        view.onButtonCloseClicked()

        XCTAssert(mockEventHandler?.invokedOnButtonCloseClickedCount == 1,
                  "Expect invoke event handler onButtonCloseClicked once")
    }

    func testActionSliderValueChanged() {
        let slider = NMRangeSlider(frame: .zero)
        slider.maximumValue = 10000
        slider.minimumValue = 10
        slider.upperValue = 10000
        slider.lowerValue = 2000

        view.onSliderValueChanged(slider)

        XCTAssert(view.labelMinPrice.text == "Rp 2.000",
                  "Expect label min price equals to 'Rp 2.000'")
        XCTAssert(view.labelMaxPrice.text == "Rp 10.000",
                  "Expect label min price equals to 'Rp 10.000'")
    }

    func testActionShopTypeClicked() {
        view.onShopTypeClicked()

        XCTAssert(mockEventHandler?.invokedOnShopTypeClickedCount == 1,
                  "Expect invoke event handler onShopTypeClicked once")
    }

    func testActionButtonApplyClicked() {
        let mockDelegate = MockSearchFilterDelegate()

        view.delegate = mockDelegate

        view.slider.maximumValue = 10000
        view.slider.minimumValue = 10
        view.slider.upperValue = 10000
        view.slider.lowerValue = 2000

        view.switchWholesale.isOn = true

        let expectedSearchFilter = SearchFilter(minPrice: "2000",
                                                maxPrice: "10000",
                                                wholesale: true,
                                                official: false,
                                                fshop: "2")

        view.onButtonApplyClicked()

        XCTAssert(mockDelegate.invokedSearchFilterDidApplyCount == 1,
                  "Expect delegate invoked with searchFilterDidApply once")

        XCTAssert(mockDelegate.invokedSearchFilterDidApplyParameters?
            .filter == expectedSearchFilter,
                  "Expected search filter sent through delegate is not same")
    }
}
