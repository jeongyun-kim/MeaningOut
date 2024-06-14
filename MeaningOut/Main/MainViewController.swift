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
    
    private lazy var searchKeywordsList: [String] = ud.searchKeywords {
        didSet {
            if searchKeywordsList.isEmpty {
                recentSearchLabel.isHidden = true
                deleteAllButton.isHidden = true
                tableView.isHidden = true
                emptyView.isHidden = false
            } else {
                recentSearchLabel.isHidden = false
                deleteAllButton.isHidden = false
                tableView.isHidden = false
                emptyView.isHidden = true
                
                tableView.reloadData()
            }
        }
    }
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = Placeholder.search.rawValue
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    private lazy var border = CustomBorder()
    
    private lazy var recentSearchLabel: UILabel = {
         let label = UILabel()
         label.font = CustomFont.bold16
         label.text = "최근 검색"
         return label
     }()
     
     private lazy var deleteAllButton: UIButton = {
         let button = UIButton()
         button.setTitle("전체 삭제", for: .normal)
         button.setTitleColor(Color.primaryColor, for: .normal)
         button.titleLabel?.font = CustomFont.regular14
         return button
     }()
    
    private lazy var emptyView = EmptyView(frame: .zero)
    
    private lazy var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupConstraints()
        setupTableView()
        setupUI()
        addActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //searchKeywordsList = ud.searchKeywords
    }
    
    func setupHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(border)
        view.addSubview(emptyView)
        view.addSubview(recentSearchLabel)
        view.addSubview(deleteAllButton)
        view.addSubview(deleteAllButton)
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
        
        recentSearchLabel.snp.makeConstraints { make in
            make.top.equalTo(border.snp.bottom).offset(16)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(24)
        }
        
        deleteAllButton.snp.makeConstraints { make in
            make.centerY.equalTo(recentSearchLabel.snp.centerY)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(recentSearchLabel.snp.bottom).offset(16)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(SearchKeywordsTableViewCell.self, forCellReuseIdentifier: SearchKeywordsTableViewCell.identifier)
        
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "\(ud.userName)'s MEANING OUT"
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = Color.black
        searchBar.delegate = self
    }
    
    func addActions() {
        deleteAllButton.addTarget(self, action: #selector(deleteAllBtnTapped), for: .touchUpInside)
    }
    
    @objc func deleteBtnTapped(_ sender: UIButton) {
        searchKeywordsList.remove(at: sender.tag)
        ud.searchKeywords = searchKeywordsList
    }
    
    @objc func deleteAllBtnTapped(_ sender: UIButton) {
        searchKeywordsList.removeAll()
        ud.searchKeywords = searchKeywordsList
    }
    
    private func pushSearchVC(_ keyword: String) {
        let vc = SearchViewController()
        vc.keyword = keyword
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchKeywordsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchKeywordsTableViewCell.identifier, for: indexPath) as? SearchKeywordsTableViewCell else { return UITableViewCell() }
        cell.configureCell(searchKeywordsList[indexPath.row])
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteBtnTapped), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let keyword = searchKeywordsList[indexPath.row]
        pushSearchVC(keyword)
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text else { return }
        
        if !searchKeywordsList.contains(keyword) {
            searchKeywordsList.insert(keyword, at: 0) // 가장 최근 검색어가 맨위에 와야하므로 검색어는 0번 인덱스에 넣어주기
            ud.searchKeywords = searchKeywordsList
        }
        
        pushSearchVC(keyword)
    }
}
