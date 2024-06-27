//
//  AlertCase.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/27/24.
//

import Foundation

enum Alert {
    case searchError
    case detailURLError
    case membershipCancel
    
    static let confirmActionTitle = "확인"
    static let cancelActionTitle = "취소"
    
    var title: String {
        switch self {
        case .searchError:
            return SearchErrorCase.title.rawValue
        case .detailURLError:
            return DetailUrlErrorCase.title.rawValue
        case .membershipCancel:
            return MembershipCancelCase.title.rawValue
        }
    }
    
    var message: String {
        switch self {
        case .searchError:
            return SearchErrorCase.message.rawValue
        case .detailURLError:
            return DetailUrlErrorCase.message.rawValue
        case .membershipCancel:
            return MembershipCancelCase.message.rawValue
        }
    }
}

enum MembershipCancelCase: String {
    case title = "회원탈퇴"
    case message = "탈퇴를 하면 데이터가 모두 초기화됩니다.\n탈퇴하시겠습니까?"
}

enum SearchErrorCase: String {
    case title = "데이터 불러오기 실패"
    case message = "오류가 계속되면 개발자에게 문의하세요"
}

enum DetailUrlErrorCase: String {
    case title = "링크 오류"
    case message = "해당 상품의 링크를 찾지 못했습니다"
}
