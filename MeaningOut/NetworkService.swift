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
    
    func fetchSearchResult(params: Parameters, completionHandler: @escaping (SearchResult) -> Void) {
        AF.request(APIData.url, parameters: params, headers: APIData.header).responseDecodable(of: SearchResult.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}
