//
//  UserDefaultsManager.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/13/24.
//

import Foundation

class UserDefaultsManager {
    // 유저인지 확인하기 (default = false)
    var isUser: Bool {
        get {
            UserDefaults.standard.bool(forKey: "isUser")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "isUser")
        }
    }
    
    var userProfileImage: String {
        get {
            UserDefaults.standard.string(forKey: "profileImage") ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "profileImage")
        }
    }
    
    var userName: String {
        get {
            UserDefaults.standard.string(forKey: "userName") ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "userName")
        }
    }
    
    var selectedImage: String {
        get {
            UserDefaults.standard.string(forKey: "selectedImage") ?? ProfileImage.randomImage.imageName
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "selectedImage")
        }
    }
}
