//
//  NetworkService.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/20/24.
//

import Foundation
import Alamofire

class NetworkService {
    private init() {}
    static let shared = NetworkService()
    
    typealias CompletionHandler<T: Decodable> = (T?, String?) -> Void
    
    func requestCall<T: Decodable>(networkCase: NetworkRequestCase, completionHandler: @escaping CompletionHandler<T>) {
        AF.request(networkCase.baseURL, method: networkCase.method, parameters: networkCase.params, headers: networkCase.headers).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value, nil)
            case .failure(let error):
                completionHandler(nil, "\(error)")
            }
        }
    }
}

extension NetworkService: NetworkCaseProtocol {
    func fetchSearchResult(sortType: SortRule, keyword: String, startPoint: Int, display: Int, completionHandler: @escaping (SearchResult?, String?) -> Void) {
        requestCall(networkCase: .search(sortType: sortType, keyword: keyword, startPoint: startPoint, display: display), completionHandler: completionHandler)
    }
}
