//
//  SearchPath.swift
//  Search
//
//  Created by Hendy Christianto on 02/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import Alamofire

private struct Constants {
    static let baseUrl = "https://ace.tokopedia.com"
}

enum SearchURL: URLRequestConvertible {
    case search(parameters: Parameters)

    var method: HTTPMethod {
        return .get
    }

    var path: String {
        switch self {
        case .search:
            return "/search/v2.5/product"
        }
    }

    func asURLRequest() throws -> URLRequest {
        guard let baseUrl = URL(string: Constants.baseUrl) else {
            throw AFError.parameterEncodingFailed(reason: .missingURL)
        }

        var urlRequest = URLRequest(url: baseUrl.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        switch self {
        case .search(let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }

        return urlRequest
    }
}
