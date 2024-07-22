//
//  LikeViewModel.swift
//  MeaningOut
//
//  Created by 김정윤 on 7/22/24.
//

import Foundation

final class LikeViewModel {
    private let repository = ItemRepository()
    
    // Input
    // 아이템 리스트 다시 불러와야할 때
    var reloadLikeItemsTrigger: Observable<Void?> = Observable(nil)
    // 좋아요 버튼 눌러서 좋아요 해제 시
    var likeBtnTapped = Observable(0)
    
    // Output
    // CollectionView에 그려질 좋아요 아이템 리스트 
    var likedItemList: Observable<[Item]> = Observable([])
    
    init() {
        reloadLikeItemsTrigger.bind { [weak self] _ in
            guard let self else { return }
            self.likedItemList.value = Array(repository.readAllItems())
        }
        
        likeBtnTapped.bind { [weak self] idx in
            guard let self else { return }
            let item = self.likedItemList.value[idx]
            self.repository.removeItem(item.productId)
            reloadLikeItemsTrigger.value = ()
        }
    }
}
