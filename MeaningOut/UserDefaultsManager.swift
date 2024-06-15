//
//  UserDefaultsManager.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/13/24.
//

import Foundation

class UserDefaultsManager {
    // 유저인지 확인하기 (default = false)
    static var isUser: Bool {
        get {
            UserDefaults.standard.bool(forKey: "isUser")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "isUser")
        }
    }
    
    static var userProfileImage: String {
        get {
            UserDefaults.standard.string(forKey: "profileImage") ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "profileImage")
        }
    }
    
    static var userName: String {
        get {
            UserDefaults.standard.string(forKey: "userName") ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "userName")
        }
    }
    
    static var selectedImage: String {
        // 사용자가 선택한 이미지가 저장되어있지않으면 랜덤이미지 불러오기
        get {
            UserDefaults.standard.string(forKey: "selectedImage") ?? ProfileImage.randomImage.imageName
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "selectedImage")
        }
    }
    
    static var searchKeywords: [String] {
        get {
            UserDefaults.standard.stringArray(forKey: "searchKeywords") ?? []
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "searchKeywords")
        }
    }
    
    static var likedItemId: [String] {
        get {
            UserDefaults.standard.stringArray(forKey: "likedItemId") ?? []
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "likedItemId")
        }
    }
    
    static var likeCnt: Int {
        get {
            UserDefaults.standard.integer(forKey: "likeCnt")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "likeCnt")
        }
    }
    
    static func deleteAllDatas() {
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
    }
}
