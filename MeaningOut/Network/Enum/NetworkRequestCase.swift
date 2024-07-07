//
//  NetworkRequestCase.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/27/24.
//

import Foundation
import Alamofire

enum NetworkRequestCase {
    case search(sortType: SortRule, keyword: String, startPoint: Int, display: Int)
    
    var baseURL: String {
        return APIData.url
    }
    
    var headers: HTTPHeaders {
        return ["X-Naver-Client-Id": APIData.clientId, "X-Naver-Client-Secret": APIData.clientSecret]
    }
    
    var params: Parameters {
        switch self {
        case .search(let sortType, let keyword, let startPoint, let display):
            return ["query": keyword, "sort": sortType, "display": display, "start": startPoint]
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
}
