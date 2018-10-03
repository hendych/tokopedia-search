//
//  SearchService.swift
//  Search
//
//  Created by Hendy Christianto on 02/10/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import Alamofire

typealias Completion = ([String: Any]?, ApiError?) -> Void

class SearchService {
    func requestSearch(_ filter: SearchFilter, start: Int, rows: Int,
                       completion: @escaping Completion) {

        var param = filter.toJson()
        param["start"] = start
        param["rows"] = rows

        let request = SessionManager.default.request(SearchURL.search(parameters: param)).validate()

        request.responseJSON { (response) in
            switch response.result {
            case .success(let value):
                completion(value as? [String: Any], nil)
            case .failure:
                let apiError = ApiError(type: .networkError)
                completion(nil, apiError)
            }
        }
    }
}
