//
//  NetworkErrorCase.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/28/24.
//

import Foundation

enum NetworkErroCase: String, Error {
    case failedRequest = "요청을 실패했습니다"
    case noData = "데이터가 없습니다"
    case invalidData = "데이터를 받아오는데 실패했습니다"
    case invalidResponse = "응답을 받아오는데 실패했습니다"
}
