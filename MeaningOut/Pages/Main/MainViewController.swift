//
//  MainViewController.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/13/24.
//

import UIKit
import SnapKit

class MainViewController: BaseTableViewController {
    private let vm = MainViewModel()
    private let baseView = BaseMainView()
    
    override func loadView() {
        self.view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        vm.viewWillAppearTrigger.value = ()
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
        vm.deleteTrigger.value = sender.tag
    }
    
    @objc func deleteAllBtnTapped(_ sender: UIButton) {
        vm.deleteAllTrigger.value = ()
    }
    
    private func bind() {
        vm.title.bind { [weak self] title in
            guard let self else { return }
            self.navigationItem.title = title
        }
        
        vm.searchKeywordsList.bind { [weak self] keywords in
            guard let self else { return }
            if keywords.isEmpty { // 검색어 없으면 emptyView 보여주기
                self.baseView.recentSearchLabel.isHidden = true
                self.baseView.deleteAllButton.isHidden = true
                self.baseView.tableView.isHidden = true
                self.baseView.emptyView.isHidden = false
            } else { // 검색어가 있다면 emptyView 숨기고 tableView 보여주기
                self.baseView.recentSearchLabel.isHidden = false
                self.baseView.deleteAllButton.isHidden = false
                self.baseView.tableView.isHidden = false
                self.baseView.emptyView.isHidden = true
                
                self.baseView.tableView.reloadData()
            }
        }
        
        vm.outputSearchResult.bind { [weak self] result in
            guard let self else { return }
            self.view.endEditing(true)
            if result {
                self.baseView.searchBar.text = ""
                let keyword = self.vm.inputSearchKeyword.value
                self.pushVC(vc: SearchViewController(keyword: keyword))
            } else {
                self.showToast(ToastMessageCase.emptyKeyword.rawValue)
            }
        }
    }
}

// MARK: TableViewExtension
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.searchKeywordsList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchKeywordsTableViewCell.identifier, for: indexPath) as? SearchKeywordsTableViewCell else { return UITableViewCell() }
        let data = vm.searchKeywordsList.value[indexPath.row]
        cell.configureCell(data)
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteBtnTapped), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let keyword = vm.searchKeywordsList.value[indexPath.row]
        pushVC(vc: SearchViewController(keyword: keyword))
    }
}

// MARK: SearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text else { return }
        vm.inputSearchKeyword.value = keyword
    }
}
