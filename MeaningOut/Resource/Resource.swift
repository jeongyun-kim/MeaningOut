//
//  Resource.swift
//  MeaningOut
//
//  Created by 김정윤 on 7/21/24.
//

import UIKit

enum Resource { 
    enum ColorCase {
        static let primaryColor = UIColor(red: 0.45, green: 0.87, blue: 0.98, alpha: 1.00) // #74ddfb
        static let black = UIColor.black
        // 회색은 진한순
        static let gray1 = UIColor(hue: 0, saturation: 0, brightness: 0.29, alpha: 1.0)
        static let gray2 = UIColor(hue: 0, saturation: 0, brightness: 0.5, alpha: 1.0)
        static let gray3 = UIColor(hue: 0, saturation: 0, brightness: 0.8, alpha: 1.0)
        static let borderColor = UIColor.systemGray5
        static let white = UIColor.white
        static let highlightColor = UIColor(red: 1.00, green: 0.80, blue: 0.30, alpha: 1.00) // #ffcb4d
    }

    enum ImageCase {
        static let launch = UIImage(named: "launch")
        static let logo = UIImage(named: "lauch_logo")
        static let onboarding = UIImage(named: "onboarding")
        static let empty = UIImage(named: "emptyImage")
        static let search = UIImage(systemName: "magnifyingglass")
        static let setting = UIImage(systemName: "person")
        static let next = UIImage(systemName: "chevron.right")
        static let clock = UIImage(systemName: "clock")
        static let delete = UIImage(systemName: "xmark")
        static let profileCamera = UIImage(systemName: "camera.fill")
        static let like_unselected = UIImage(systemName: "heart")
        static let like_selected = UIImage(systemName: "heart.fill")
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
    
}
