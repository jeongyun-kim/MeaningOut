//
//  Item.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/14/24.
//

import UIKit

struct item {
    let title: String
    let link: String
    let image: String
    let lprice: String
    let mallName: String
    let productId: String
    
    // 새로이 검색했을 때 아이템을 map으로 가져오면서 isLike = false로 사용했을 때, '좋아요'한 아이템들도 false 처리해버려서
    // 좋아요한 이력은 있지만 컬렉션뷰에 제대로 출력되지 않음
    // => 아예 UserDefault에 저장된 아이디값들이랑 비교해서 현재 아이템의 아이디가 포함되어있으면 true / 아니면 false로 처리 
    var isLike: Bool {
        get {
            UserDefaultsManager.likedItemId.contains(productId) ? true : false
        }
    }
    
    var replacedTitle: String {
        var title = title.replacingOccurrences(of: #"</b>"#, with: "")
        title = title.replacingOccurrences(of: "<b>", with: "")
        return title
    }
    
    var url: URL {
        return URL(string: image)!
    }
    
    var price: String {
        return "\(Int(lprice)!.formatted())원"
    }
    
    var likeImage: UIImage {
        return isLike ? ImageCase.like_selected! : ImageCase.like_unselected!
    }
    
    var likeTintColor: UIColor {
        return isLike ? ColorCase.black : ColorCase.white
    }
    
    var likeBackgroundColor: UIColor {
        return isLike ? ColorCase.white : ColorCase.black.withAlphaComponent(0.3)
    }
}
