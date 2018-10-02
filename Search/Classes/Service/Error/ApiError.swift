//
//  ApiError.swift
//  Search
//
//  Created by Hendy Christianto on 02/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import Foundation

enum ApiErrorType: Equatable {
    case apiError(message: String)
    case networkError
    case unexpectedError
}

struct ApiError: Error, Equatable {
    let type: ApiErrorType

    var message: String {
        switch type {
        case .apiError(let errorMessage):
            return errorMessage
        case .networkError:
            return "An error network has occurred. Please check your connection and try again later."
        case .unexpectedError:
            return "Unexpected error has occurred. Please try again later."
        }
    }

    init(type: ApiErrorType) {
        self.type = type
    }

    static func == (lhs: ApiError, rhs: ApiError) -> Bool {
        return lhs.type == rhs.type
    }
}
