//
//  User.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/14/24.
//

import Foundation

struct User {
    var userName: String {
        UserDefaultsManager().userName
    }
    
    var profileImage: String {
        UserDefaultsManager().userProfileImage
    }
}
