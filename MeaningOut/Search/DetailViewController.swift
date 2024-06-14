//
//  DetailViewController.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/14/24.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController, SetupView {
   
    lazy var selectedItem: SearchItem = SearchItem(title: "", link: "", image: "", lprice: "", mallName: "", productId: "")
   
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
        navigationItem.title = selectedItem.replacedTitle
    }
    
}
