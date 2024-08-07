//
//  TableViewCase.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/27/24.
//

import Foundation

extension Resource {
    enum SettingCellTitle: String, CaseIterable {
        case likeList = "나의 장바구니 목록"
        case question = "자주 묻는 질문"
        case contact = "1:1 문의"
        case notification = "알림 설정"
        case cancel = "탈퇴하기"
        
        var likeCnt: Int {
            switch self {
            case .likeList:
                guard let userData = UserDataRepository().readUserData() else { return 0 }
                return userData.likedItemList.count
            default:
                return 0
            }
        }
    }
}
