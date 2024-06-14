//
//  SearchViewController.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/14/24.
//

import UIKit

class SearchViewController: UIViewController, SetupView {

    lazy var keyword: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupConstraints()
        setupUI()
    }
    
    func setupHierarchy() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = keyword
    }
}
