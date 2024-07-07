//
//  CollectionViewCase.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/27/24.
//

import Foundation

enum TagName: String, CaseIterable {
    case sim = "정확도순"
    case date = "날짜순"
    case dsc = "가격높은순"
    case asc = "가격낮은순"
}


enum CollectionViewType {
    case search
    case like
}
