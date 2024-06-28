//
//  URLComponentsManager.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/28/24.
//

import Foundation

class URLComponentsManager {
    private init() {}
    static let shared = URLComponentsManager()
    
    func NaverSearchURLComponents(sortType: SortRule, keyword: String, startPoint: Int, display: Int) -> URL? {
        var components = URLComponents() // 구조체라 var로 선언해줘야 수정 가능
        components.scheme = "https"
        components.host = "openapi.naver.com"
        components.path = "/v1/search/shop.json"
        components.queryItems = [
            URLQueryItem(name: "query", value: keyword),
            URLQueryItem(name: "sort", value: "\(sortType)"),
            URLQueryItem(name: "display", value: "\(display)"),
            URLQueryItem(name: "start", value: "\(startPoint)")
        ]
        return components.url
    }
}
