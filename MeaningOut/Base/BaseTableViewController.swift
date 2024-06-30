//
//  BaseTableViewController.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/30/24.
//

import UIKit

class BaseTableViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        addActions()
    }
    
    func setupUI() {
        navigationController?.navigationBar.tintColor = ColorCase.black
        view.backgroundColor = .systemBackground
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    func setupTableView() {
        
    }
    
    func addActions() {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
