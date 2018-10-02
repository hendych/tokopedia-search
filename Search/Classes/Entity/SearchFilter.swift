//
//  SearchFilter.swift
//  Search
//
//  Created by Hendy Christianto on 02/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import Foundation

struct SearchFilter: Equatable {
    let query = "samsung"

    private(set) var minPrice = "100"
    private(set) var maxPrice = "8000000"
    private(set) var wholesale = false
    private(set) var official = true
    private(set) var fshop = "2"

    init(minPrice: String, maxPrice: String, wholesale: Bool, official: Bool, fshop: String) {
        self.minPrice = minPrice
        self.maxPrice = maxPrice
        self.wholesale = wholesale
        self.official = official
        self.fshop = fshop
    }

    func toJson() -> [String: Any] {
        return [
            "q": query,
            "pmin": minPrice,
            "pmax": maxPrice,
            "wholesale": wholesale,
            "official": official,
            "fshop": fshop
        ]
    }
}
