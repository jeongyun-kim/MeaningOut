//
//  SetupView.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/13/24.
//

import Foundation

@objc
protocol SetupView {
    func setupHierarchy()
    func setupConstraints()
    @objc optional func setupUI()
    @objc optional func addActions() 
    @objc optional func setupTableView()
    @objc optional func setupCollectionView()
}
