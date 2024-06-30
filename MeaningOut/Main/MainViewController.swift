//
//  MainViewController.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/13/24.
//

import UIKit
import SnapKit

class MainViewController: BaseTableViewController {

    private let baseView = BaseMainView()
    private let ud = UserDefaultsManager.shared
    private lazy var searchKeywordsList: [String] = ud.searchKeywords {
        didSet {
            if searchKeywordsList.isEmpty { // 검색어 없으면 emptyView 보여주기
                baseView.recentSearchLabel.isHidden = true
                baseView.deleteAllButton.isHidden = true
                baseView.tableView.isHidden = true
                baseView.emptyView.isHidden = false
            } else { // 검색어가 있다면 emptyView 숨기고 tableView 보여주기
                baseView.recentSearchLabel.isHidden = false
                baseView.deleteAllButton.isHidden = false
                baseView.tableView.isHidden = false
                baseView.emptyView.isHidden = true
                
                baseView.tableView.reloadData()
            }
        }
    }
    
    override func loadView() {
        self.view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchKeywordsList = ud.searchKeywords
        navigationItem.title = "\(ud.userName)'s MEANING OUT"
    }

    override func setupTableView() {
        baseView.tableView.delegate = self
        baseView.tableView.dataSource = self
    }
    
    override func setupUI() {
        super.setupUI()
        baseView.searchBar.delegate = self
    }
    
    override func addActions() {
        baseView.deleteAllButton.addTarget(self, action: #selector(deleteAllBtnTapped), for: .touchUpInside)
    }
    
    @objc func deleteBtnTapped(_ sender: UIButton) {
        searchKeywordsList.remove(at: sender.tag)
        ud.searchKeywords = searchKeywordsList
    }
    
    @objc func deleteAllBtnTapped(_ sender: UIButton) {
        searchKeywordsList.removeAll()
        ud.searchKeywords = searchKeywordsList
    }
}

// MARK: TableViewExtension
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
        pushVC(vc: SearchViewController(keyword: keyword))
    }
}

// MARK: SearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text else { return }
        
        if !searchKeywordsList.contains(keyword) {
            searchKeywordsList.insert(keyword, at: 0) // 가장 최근 검색어가 맨위에 와야하므로 검색어는 0번 인덱스에 넣어주기
            ud.searchKeywords = searchKeywordsList
        }
        
        searchBar.text = ""
        view.endEditing(true)
        pushVC(vc: SearchViewController(keyword: keyword))
    }
}
