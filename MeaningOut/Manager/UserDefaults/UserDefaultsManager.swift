//
//  UserDefaultsManager.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/13/24.
//

import Foundation

@propertyWrapper
struct UserDefaultsWrapper<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get { return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
}

class UserDefaultsManager {
    private init () { }
    static let shared = UserDefaultsManager()
    
    // 유저인지 확인하기 (default = false)
    @UserDefaultsWrapper(key: "isUser", defaultValue: false) var isUser: Bool
    
    @UserDefaultsWrapper(key: "profileImage", defaultValue: ProfileImage.randomImage.imageName) var userProfileImage: String
   
    @UserDefaultsWrapper(key: "userName", defaultValue: "") var userName: String
    
    @UserDefaultsWrapper(key: "joinDate", defaultValue: "") var joinDate: String
    
    @UserDefaultsWrapper(key: "searchKeywords", defaultValue: []) var searchKeywords: [String]
    
    @UserDefaultsWrapper(key: "likedItemId", defaultValue: []) var likedItemId: [String]
    
    @UserDefaultsWrapper(key: "likeCnt", defaultValue: 0) var likeCnt: Int

    func deleteAllDatas() {
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
    }
}
