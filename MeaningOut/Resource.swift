//
//  Resource.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/13/24.
//

import UIKit

enum ColorCase {
    static let primaryColor = UIColor(hue: 0.0639, saturation: 0.7, brightness: 0.93, alpha: 1.0)
    static let black = UIColor.black
    // 회색은 진한순
    static let gray1 = UIColor(hue: 0, saturation: 0, brightness: 0.29, alpha: 1.0)
    static let gray2 = UIColor(hue: 0, saturation: 0, brightness: 0.5, alpha: 1.0)
    static let gray3 = UIColor(hue: 0, saturation: 0, brightness: 0.8, alpha: 1.0)
    static let borderColor = UIColor.systemGray5
    static let white = UIColor.white
}

enum ImageCase {
    static let launch = UIImage(named: "launch")
    static let empty = UIImage(named: "empty")
    static let search = UIImage(systemName: "magnifyingglass")
    static let setting = UIImage(systemName: "person")
    static let next = UIImage(systemName: "chevron.right")
    static let clock = UIImage(systemName: "clock")
    static let delete = UIImage(systemName: "xmark")
    static let profileCamera = UIImage(systemName: "camera.fill")
    static let like_unselected = UIImage(named: "like_unselected")
    static let like_selected = UIImage(named: "like_selected")
}

enum BorderCase {
    static let profile: CGFloat = 5
    static let selected: CGFloat = 3
    static let deselected: CGFloat = 1
}

enum FontCase {
    static let bold48 = UIFont.systemFont(ofSize: 48, weight: .bold)
    static let bold20 = UIFont.systemFont(ofSize: 20, weight: .bold)
    static let bold16 = UIFont.systemFont(ofSize: 16, weight: .bold)
    static let regular15 = UIFont.systemFont(ofSize: 15)
    static let regular14 = UIFont.systemFont(ofSize: 14)
    static let regular13 = UIFont.systemFont(ofSize: 13)
}

enum Placeholder: String {
    case nickname = "닉네임을 입력해주세요 :) "
    case search = "브랜드, 상품 등을 입력하세요"
}

enum NicknameRegex {
    static let specialCharacter = "(?=.*[@#$%])"
    static let number = "(?=.*[0-9])"
}

enum NicknameCheckType: String {
    case confirm = "사용할 수 있는 닉네임이에요"
    case wrongNicknameCnt = "2글자 이상 10글자 미만으로 설정해주세요"
    case containsNumber = "닉네임에 숫자는 포함할 수 없어요"
    case containsSpecialCharacter = "닉네임에 @, #, $, %는 포함할 수 없어요"
}

enum ProfileViewType: String {
    case setting = "PROFILE SETTING"
    case edit = "EDIT PROFILE"
}

enum CornerRadiusCase: Int {
    case none = 0
    case image, button = 6
    case label = 15
}

enum TagName: String, CaseIterable {
    case sim = "정확도순"
    case date = "날짜순"
    case dsc = "가격높은순"
    case asc = "가격낮은순"
}

enum SettingCellTitle: String, CaseIterable {
    case likeList = "나의 장바구니 목록"
    case question = "자주 묻는 질문"
    case contact = "1:1 문의"
    case notification = "알림 설정"
    case cancel = "탈퇴하기"
}
