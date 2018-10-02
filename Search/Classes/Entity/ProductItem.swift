//
//  ProductItem.swift
//  Search
//
//  Created by Hendy Christianto on 02/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import Foundation

struct ProductItem: Equatable {
    private(set) var id = 0
    private(set) var name = ""
    private(set) var uri = ""
    private(set) var imageUri = ""
    private(set) var imageUri700 = ""
    private(set) var price = ""
    private(set) var priceRange = ""

    init?(json: Any?) {
        guard let json = json as? [String: Any] else {
            return nil
        }

        self.id = json["id"] as? Int ?? 0
        self.name = json["name"] as? String ?? ""
        self.uri = json["uri"] as? String ?? ""
        self.imageUri = json["image_uri"] as? String ?? ""
        self.imageUri700 = json["image_uri_700"] as? String ?? ""
        self.price = json["price"] as? String ?? ""
        self.priceRange = json["price_range"] as? String ?? ""
    }
}
