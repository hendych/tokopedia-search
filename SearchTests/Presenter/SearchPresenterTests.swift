//
//  SearchPresenterTests.swift
//  SearchTests
//
//  Created by Hendy Christianto on 02/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import XCTest
@testable import Search

class SearchPresenterTests: XCTestCase {

    var mockRouter: MockSearchRouter?
    var mockView: MockSearchView?
    var mockInteractor: MockSearchInteractorInput?
    var presenter: SearchPresenter?

    override func setUp() {
        let router = MockSearchRouter()
        let interactor = MockSearchInteractorInput()

        mockView = MockSearchView()
        mockRouter = router
        mockInteractor = interactor

        presenter = SearchPresenter(interactor: interactor, router: router)
        presenter?.view = mockView
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
