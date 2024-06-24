//
//  UserDefaultsManager.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/13/24.
//

import Foundation

class UserDefaultsManager {
    private init () { }
    static let shared = UserDefaultsManager()
    let standard = UserDefaults.standard
    
    // 유저인지 확인하기 (default = false)
    var isUser: Bool {
        get {
            standard.bool(forKey: "isUser")
        }
        set {
            standard.setValue(newValue, forKey: "isUser")
        }
    }
    
    var userProfileImage: String {
        get {
            standard.string(forKey: "profileImage") ?? ProfileImage.randomImage.imageName
        }
        set {
            standard.setValue(newValue, forKey: "profileImage")
        }
    }
    
   var userName: String {
        get {
            standard.string(forKey: "userName") ?? ""
        }
        set {
            standard.setValue(newValue, forKey: "userName")
        }
    }
    
    var joinDate: String {
        get {
            standard.string(forKey: "joinDate") ?? ""
        }
        set {
            standard.setValue(newValue, forKey: "joinDate")
        }
    }
    
    var searchKeywords: [String] {
        get {
            standard.stringArray(forKey: "searchKeywords") ?? []
        }
        set {
            standard.setValue(newValue, forKey: "searchKeywords")
        }
    }
    
    var likedItemId: [String] {
        get {
            standard.stringArray(forKey: "likedItemId") ?? []
        }
        set {
            standard.setValue(newValue, forKey: "likedItemId")
        }
    }
    
    var likeCnt: Int {
        get {
            standard.integer(forKey: "likeCnt")
        }
        set {
            standard.setValue(newValue, forKey: "likeCnt")
        }
    }
    
    func deleteAllDatas() {
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
    }
}
