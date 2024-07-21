//
//  NetworkCaseProtocol.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/28/24.
//

import Foundation

protocol NetworkCaseProtocol {
    func fetchSearchResult(sortType: SortRule, keyword: String, startPoint: Int, display: Int, completionHandler: @escaping (SearchResult?, String?) -> Void)
}
