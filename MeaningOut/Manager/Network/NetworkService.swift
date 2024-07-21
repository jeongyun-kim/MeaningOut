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
    typealias URLSessionCompletionHandler<T: Decodable> = (T?, NetworkErroCase?) -> Void
    
    func requestAFCall<T: Decodable>(networkCase: NetworkRequestCase, completionHandler: @escaping CompletionHandler<T>) {
        AF.request(networkCase.baseURL, method: networkCase.method, parameters: networkCase.params, headers: networkCase.headers).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value, nil)
            case .failure(let error):
                completionHandler(nil, "\(error)")
            }
        }
    }
    
    func requestURLSessionCall<T: Decodable>(session: URLSession = .shared, model: T.Type, networkCase: NetworkRequestCase, completionHandler: @escaping URLSessionCompletionHandler<T>) {
        switch networkCase {
        case .search(let sortType, let keyword, let startPoint, let display):
            // URL Components로 구성한 url 받아오기
            guard let url = URLComponentsManager.shared.NaverSearchURLComponents(sortType: sortType, keyword: keyword, startPoint: startPoint, display: display) else { return }
            // URLSession Requset 생성하기
            var request = URLRequest(url: url) // 구조체라 변경해줄거면 var로
            // request에 header 추가
            request.addValue(APIData.clientId, forHTTPHeaderField: "X-Naver-Client-Id")
            request.addValue(APIData.clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
            // 요청 보내기
            session.customURLSessionDataTask(request) { data, response, error in
                // error가 없다면 패스 아니면 failedRequest
                guard error == nil else {
                    completionHandler(nil, .failedRequest)
                    return
                }
                // 데이터값이 있을 때 패스, 아니면 noData
                guard let data = data else {
                    completionHandler(nil, .noData)
                    return
                }
                // response값도 있다면 패스, 아니면 invalidResponse
                guard let response = response as? HTTPURLResponse else {
                    completionHandler(nil, .invalidResponse)
                    return
                }
                // statusCode가 200이면 패스, 아니면 failedRequest
                guard response.statusCode == 200 else {
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                // 여기부터 데이터 사용 가능
                // - Data > JSON > Struct(Model)
                do {
                    let result = try JSONDecoder().decode(model.self, from: data)
                    completionHandler(result, nil)
                } catch {
                    completionHandler(nil, .invalidData)
                }
            }
        }
    }
}

extension NetworkService: NetworkCaseProtocol {
    func fetchSearchResult(sortType: SortRule, keyword: String, startPoint: Int, display: Int, completionHandler: @escaping (SearchResult?, String?) -> Void) {
        requestAFCall(networkCase: .search(sortType: sortType, keyword: keyword, startPoint: startPoint, display: display), completionHandler: completionHandler)
    }
}
