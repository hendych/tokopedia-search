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

    let minPrice: String
    let maxPrice: String
    let wholesale: Bool
    let official: Bool
    let fshop: String

    init() {
        self.init(minPrice: "10000", maxPrice: "800000",
                  wholesale: false,
                  official: false, fshop: "")
    }

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
