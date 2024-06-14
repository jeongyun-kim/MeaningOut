//
//  SearchResult.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/14/24.
//

import Foundation

struct SearchResult: Codable {
    let lastBuildDate: String
    let total: Int
    let start: Int
    let items: [resultItem]
}

struct resultItem: Codable {
    let title: String
    let link: String
    let image: String
    let lprice: String
    let mallName: String
    let productId: String
}
