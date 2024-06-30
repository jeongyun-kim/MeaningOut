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
    static func itemCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionInsetAndSpacing: CGFloat = 16
        let size = (UIScreen.main.bounds.width - sectionInsetAndSpacing * 3) / 2
        
        layout.minimumLineSpacing = sectionInsetAndSpacing
        layout.minimumInteritemSpacing = sectionInsetAndSpacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionInsetAndSpacing, bottom: sectionInsetAndSpacing, right: sectionInsetAndSpacing)
        layout.itemSize = CGSize(width: size, height: size*1.7)
        
        return layout
    }
}
