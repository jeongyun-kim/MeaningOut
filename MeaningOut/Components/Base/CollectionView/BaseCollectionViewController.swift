//
//  BaseCollectionViewController.swift
//  MeaningOut
//
//  Created by 김정윤 on 7/7/24.
//

import UIKit

class BaseCollectionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupConstraints()
        setupUI()
        setupCollectionView()
    }
    
    func setupHierarchy() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
    }
    
    func setupCollectionView() {
        
    }
}
