//
//  SettingViewController.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/13/24.
//

import UIKit
import SnapKit

class SettingViewController: UIViewController, SetupView {

    lazy var ud = UserDefaultsManager.self
    
    lazy var border = CustomBorder()

    lazy var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupConstraints()
        setupTableView()
        setupUI()
    }
    
    func setupHierarchy() {
        view.addSubview(border)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        border.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(border.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(SettingTableViewHeader.self, forHeaderFooterViewReuseIdentifier: SettingTableViewHeader.identifier)
        
        tableView.sectionHeaderTopPadding = 0
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = UITableView.automaticDimension
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "SETTING"
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SettingTableViewHeader.identifier) as! SettingTableViewHeader
        return header
    }

}
