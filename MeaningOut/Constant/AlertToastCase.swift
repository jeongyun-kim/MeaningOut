//
//  AlertCase.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/27/24.
//

import Foundation


extension Resource {
    enum Alert {
        case searchError
        case detailURLError
        case membershipCancel
        
        static let confirmActionTitle = "확인"
        static let cancelActionTitle = "취소"
        
        var title: String {
            switch self {
            case .searchError:
                return "데이터 불러오기 실패"
            case .detailURLError:
                return "링크 오류"
            case .membershipCancel:
                return "회원탈퇴"
            }
        }
        
        var message: String {
            switch self {
            case .searchError:
                return "오류가 계속되면 개발자에게 문의하세요"
            case .detailURLError:
                return "해당 상품의 링크를 찾지 못했습니다"
            case .membershipCancel:
                return "탈퇴를 하면 데이터가 모두 초기화됩니다.\n탈퇴하시겠습니까?"
            }
        }
    }
    
    enum ToastMessageCase: String {
        case emptyKeyword = "검색어를 확인해주세요"
    }
}
