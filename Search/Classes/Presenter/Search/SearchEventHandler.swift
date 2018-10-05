//
//  SearchEventHandler.swift
//  Search
//
//  Created by Hendy Christianto on 02/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import Foundation

protocol SearchEventHandler: class {
    func onRequestSearch(withFilter filter: SearchFilter, start: Int, num: Int)

    func onButtonFilterClicked(withFilter filter: SearchFilter)
}
