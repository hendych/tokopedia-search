//
//  Router.swift
//  Search
//
//  Created by Hendy Christianto on 02/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import Foundation

protocol Router {
    associatedtype NavigationType

    var viewController: NavigationType { get }
}
