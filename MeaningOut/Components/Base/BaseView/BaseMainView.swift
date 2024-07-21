//
//  BaseMainView.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/30/24.
//

import UIKit
import SnapKit

class BaseMainView: BaseView {
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = Resource.Placeholder.search.rawValue
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    let border = CustomBorder()
    let recentSearchLabel = CustomLabel(title: "최근 검색", fontCase: Resource.FontCase.bold16)
    let deleteAllButton: UIButton = {
         let button = UIButton()
         button.setTitle("전체 삭제", for: .normal)
        button.setTitleColor(Resource.ColorCase.primaryColor, for: .normal)
        button.titleLabel?.font = Resource.FontCase.regular14
         return button
     }()
    let emptyView = EmptyView(frame: .zero)
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
    }
    
    override func setupHierarchy() {
        addSubview(searchBar)
        addSubview(border)
        addSubview(emptyView)
        addSubview(recentSearchLabel)
        addSubview(deleteAllButton)
        addSubview(deleteAllButton)
        addSubview(tableView)
    }
    
    override func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(44)
        }
        
        border.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(border.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        recentSearchLabel.snp.makeConstraints { make in
            make.top.equalTo(border.snp.bottom).offset(16)
            make.leading.equalTo(safeAreaLayoutGuide).offset(24)
        }
        
        deleteAllButton.snp.makeConstraints { make in
            make.centerY.equalTo(recentSearchLabel.snp.centerY)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(24)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(recentSearchLabel.snp.bottom).offset(16)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func setupTableView() {
        tableView.register(SearchKeywordsTableViewCell.self, forCellReuseIdentifier: SearchKeywordsTableViewCell.identifier)
        
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
