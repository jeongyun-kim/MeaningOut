//
//  UICollectionVIewLayout + Extension.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/30/24.
//

import UIKit

extension UICollectionViewLayout {
    // 태그 컬렉션뷰 레이아웃
    static func searchTagCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(8)
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    // 검색결과 컬렉션뷰 레이아웃
    static func itemCollectionViewLayout(_ type: CollectionViewType = .search) -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionInsetAndSpacing: CGFloat = 16
        var size: CGFloat
        
        layout.minimumLineSpacing = sectionInsetAndSpacing
        layout.minimumInteritemSpacing = sectionInsetAndSpacing
        switch type {
        case .like:
            size = (UIScreen.main.bounds.width - sectionInsetAndSpacing * 4) / 3
            layout.itemSize = CGSize(width: size, height: size*2.5)
            layout.sectionInset = UIEdgeInsets(top: sectionInsetAndSpacing, left: sectionInsetAndSpacing, bottom: sectionInsetAndSpacing, right: sectionInsetAndSpacing)
        case .search:
            size = (UIScreen.main.bounds.width - sectionInsetAndSpacing * 3) / 2
            layout.itemSize = CGSize(width: size, height: size*1.7)
            layout.sectionInset = UIEdgeInsets(top: 0, left: sectionInsetAndSpacing, bottom: sectionInsetAndSpacing, right: sectionInsetAndSpacing)
        }
        
        return layout
    }
}
