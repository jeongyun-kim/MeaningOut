//
//  UICollectionView + Extension.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/29/24.
//

import UIKit

extension UICollectionView {
    func scrollToTheTop() {
        scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    }
}
