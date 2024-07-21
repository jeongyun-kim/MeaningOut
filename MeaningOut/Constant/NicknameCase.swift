//
//  NicknameCase.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/27/24.
//

import UIKit

extension Resource {
    enum NicknameRegex {
        static let specialCharacter = "(?=.*[@#$%])"
        static let number = "(?=.*[0-9])"
    }
    
    enum NicknameCheckType: String {
        case confirm = "사용할 수 있는 닉네임이에요"
        case empty = ""
        case wrongNicknameCnt = "2글자 이상 10글자 미만으로 설정해주세요"
        case containsNumber = "닉네임에 숫자는 포함할 수 없어요"
        case containsSpecialCharacter = "닉네임에 @, #, $, %는 포함할 수 없어요"
    }
    
    enum NicknameErrorCase: Error {
        case empty
        case wrongNicknameCnt
        case containsNumber
        case containsSpecialCharacter
    }
}
