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
    let items: [item]
}

struct item: Codable {
    let title: String
    let link: String
    let image: String
    let lprice: String
    let mallName: String
    
    var replacedTitle: String {
        var title = title.replacingOccurrences(of: #"</b>"#, with: "")
        title = title.replacingOccurrences(of: "<b>", with: "")
        return title
    }
    
    var url: URL {
        return URL(string: image)!
    }
    
    var price: String {
        return "\(Int(lprice)!.formatted())원"
    }
}
