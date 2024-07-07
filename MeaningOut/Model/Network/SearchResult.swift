//
//  SearchResult.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/14/24.
//

import UIKit

struct SearchResult: Codable {
    let lastBuildDate: String
    let total: Int
    let start: Int
    let items: [resultItem]
}

struct resultItem: Codable {
    let title: String
    let link: String
    let imagePath: String
    let price: String
    let mallName: String
    let productId: String
  
    enum CodingKeys: String, CodingKey {
        case title
        case link
        case imagePath = "image"
        case price = "lprice"
        case mallName
        case productId
    }
}

extension resultItem {
    // 새로이 검색했을 때 아이템을 map으로 가져오면서 isLike = false로 사용했을 때, '좋아요'한 아이템들도 false 처리해버려 좋아요한 이력은 있지만 컬렉션뷰에 제대로 출력되지 않음
    // => 아예 저장된 아이디값들이랑 비교해서 현재 아이템의 아이디가 포함되어있으면 true / 아니면 false로 처리
    var isLike: Bool {
        guard let userData = UserDataRepository().readUserData() else { return false }
        // 좋아요한 아이템들의 아이디 리스트
        let likedIdList = userData.likedItemList.projectTo.productId
        // 현재 상품의 아이디가 좋아요한 이력이 있는 아이디라면
        if likedIdList.contains(productId) {
            return true
        }
        return false
    }
    
    var replacedTitle: String {
        var title = title.replacingOccurrences(of: #"</b>"#, with: "")
        title = title.replacingOccurrences(of: "<b>", with: "")
        return title
    }
    
    var url: URL? {
        guard let url = URL(string: imagePath) else { return nil }
        return url
    }
    
    var priceString: String? {
        guard let price = Int(price) else { return nil }
        return "\(price.formatted())원"
    }
    
    // 좋아요 버튼 이미지
    var likeBtnImage: UIImage? {
        guard let isLikeImage = isLike ? ImageCase.like_selected : ImageCase.like_unselected else { return nil }
        return isLikeImage
    }
    
    // 좋아요 버튼 틴트컬러
    var likeBtnTintColor: UIColor {
        return isLike ? ColorCase.black : ColorCase.white
    }
    
    // 좋아요 버튼 백그라운드
    var likeBtnBackgroundColor: UIColor {
        return isLike ? ColorCase.white : ColorCase.black.withAlphaComponent(0.3)
    }
    
    static func addOrRemoveLikeItem(_ data: resultItem) {
        let repository = UserDataRepository()
        guard let userData = repository.readUserData() else { return }
        let item = Item(productId: data.productId, title: data.replacedTitle, link: data.link, imagePath: data.imagePath, price: data.priceString ?? "", mallName: data.mallName)
        repository.updateUserLikeItemList(item)
    }
}
