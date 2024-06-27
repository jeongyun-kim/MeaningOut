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
    
    typealias CompletionHandler = (SearchResult?, String?) -> Void
    
    func fetchSearchResult(networkCase: NetworkRequestCase, completionHandler: @escaping CompletionHandler) {
        AF.request(networkCase.baseURL, method: networkCase.method, parameters: networkCase.params, headers: networkCase.headers).responseDecodable(of: SearchResult.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value, nil)
            case .failure(let error):
                completionHandler(nil, "\(error)")
            }
        }
    }
}
