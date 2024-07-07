//
//  ItemRepository.swift
//  MeaningOut
//
//  Created by 김정윤 on 7/7/24.
//

import RealmSwift

class ItemRepository {
    private let realm = try! Realm()
    
    // 아이템 모델로 생성된 모든 아이템 불러오기
    func readAllItems() -> Results<Item> {
        return realm.objects(Item.self)
    }
    
    // 아이템 삭제하기
    func removeItem(_ productId: String) {
        let item = readAllItems().where { $0.productId == productId }
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print("아이템 삭제 실패")
        }
    }
}
