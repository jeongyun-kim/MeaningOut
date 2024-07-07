//
//  Item.swift
//  MeaningOut
//
//  Created by 김정윤 on 7/6/24.
//

import RealmSwift

class Item: Object {
    @Persisted (primaryKey: true) var productId: String
    @Persisted var title: String
    @Persisted var link: String
    @Persisted var imagePath: String
    @Persisted var price: String
    @Persisted var mallName: String
    
    convenience init(productId: String, title: String, link: String, imagePath: String, price: String, mallName: String) {
        self.init()
        self.productId = productId
        self.title = title
        self.link = link
        self.imagePath = imagePath
        self.price = price
        self.mallName = mallName
    }
}
