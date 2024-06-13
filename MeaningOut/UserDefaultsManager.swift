//
//  UserDefaultsManager.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/13/24.
//

import Foundation

struct UserDefaultsManager {
    // 유저인지 확인하기 (default = false)
    static var isUser: Bool {
        return UserDefaults.standard.bool(forKey: "isUser")
    }
}
