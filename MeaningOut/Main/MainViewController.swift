//
//  MainViewController.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/13/24.
//

import UIKit
import SnapKit

class MainViewController: UIViewController, SetupView {

    lazy var ud = UserDefaultsManager.self
    
    lazy var searchKeywords: [String] = ud.searchKeywords {
        didSet {
            if searchKeywords.isEmpty {
                recentSearchView.isHidden = true
                tableView.isHidden = true
                emptyView.isHidden = false
            } else {
                recentSearchView.isHidden = false
                tableView.isHidden = false
                emptyView.isHidden = true
            }
        }
    }
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = Placeholder.search.rawValue
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    lazy var border = CustomBorder()
    
    lazy var emptyView = EmptyView(frame: .zero)
    
    lazy var recentSearchView = RecentSearchedKeywordsView(frame: .zero)
    
    lazy var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupConstraints()
        setupTableView()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ud.searchKeywords = ["오옹"]
        searchKeywords = ud.searchKeywords
    }
    
    func setupHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(border)
        view.addSubview(emptyView)
        view.addSubview(recentSearchView)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(44)
        }
        
        border.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(border.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        recentSearchView.snp.makeConstraints { make in
            make.top.equalTo(border.snp.bottom).offset(16)
            make.height.equalTo(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(recentSearchView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "\(ud.userName)'s MEANING OUT"
        recentSearchView.isHidden = true
        tableView.isHidden = true
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
