//
//  UserDataRepository.swift
//  MeaningOut
//
//  Created by 김정윤 on 7/6/24.
//

import RealmSwift

class UserDataRepository {
    private let realm = try! Realm()
    private let itemRepo = ItemRepository()
    
    // 사용자 정보 불러오기
    func readUserData() -> UserData? {
        guard let userData = realm.objects(UserData.self).first else { return nil }
        return userData
    }

    // 사용자 가입
    func createUserData(name: String, profileImage: String, joinDate: String) {
        let data = UserData(userName: name, userImage: profileImage, joinDate: joinDate, searchKeywords: List(), likedItemList: List())
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            print("addError")
        }
    }
    
    func updateUserData(value: [String: Any]) {
        do {
            try realm.write {
                realm.create(UserData.self, value: value, update: .modified)
            }
        } catch {
            print("updateError")
        }
    }
    
    // 좋아요 등록/해제
    func updateUserLikeItemList(_ item: Item) {
        guard let userData = readUserData() else { return }
        // 좋아요 한 상품들
        let likedItemList = userData.likedItemList
        // 좋아요 한 상품 아이디들
        let likedIdList = likedItemList.projectTo.productId
        
        // 좋아요한 이력이 있는 상품이라면
        if likedIdList.contains(item.productId) {
            // 저장되어있던 아이템 자체를 삭제 -> 자동으로 likedItemList에서 해당 아이템 삭제
            itemRepo.removeItem(item.productId)
        } else {
            // 좋아요한 이력이 없다면
            do {
                try realm.write {
                    // 좋아요한 아이템 리스트에 추가 -> 자동으로 Item 생성
                    likedItemList.append(item)
                }
            } catch {
                print("좋아요 실패!")
            }
        }
    }
    
    // 탈퇴할 때 사용
    func removeAllUserData() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print("deleteError")
        }
    }
}
