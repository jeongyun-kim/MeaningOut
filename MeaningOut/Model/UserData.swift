//
//  UserData.swift
//  MeaningOut
//
//  Created by 김정윤 on 7/6/24.
//

import RealmSwift

class UserData: Object {
    @Persisted (primaryKey: true) var id: ObjectId
    @Persisted var userName: String
    @Persisted var userProfileImageName: String
    @Persisted var joinDate: String
    @Persisted var searchKeywords: List<String>
    @Persisted var likedItemList: List<Item>
    
    convenience init(userName: String, userImage: String, joinDate: String, searchKeywords: List<String>, likedItemList: List<Item>) {
        self.init()
        self.userName = userName
        self.userProfileImageName = userImage
        self.joinDate = joinDate
        self.searchKeywords = searchKeywords
        self.likedItemList = likedItemList
    }
}
