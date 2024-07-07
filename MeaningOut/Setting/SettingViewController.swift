//
//  SettingViewController.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/13/24.
//

import UIKit
import SnapKit

class SettingViewController: UIViewController, SetupView {
    private let repository = UserDataRepository()
    private let border = CustomBorder()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupConstraints()
        setupTableView()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 프로필 수정화면에서 설정화면으로 다시 오면 수정화면에서 선택했던 임시프로필데이터를 현재 찐프로필데이터로 덮기
        // <- 프로필 닉네임 수정화면에서 임시프로필데이터를 기준으로 이미지를 보여주고 있기 때문 
        guard let userData = repository.readUserData() else { return }
        ProfileImage.tempSelectedProfileImage = ProfileImage(imageName: userData.userProfileImageName)
        // 좋아요 등록/해제하고 왔을 때, 바뀐 데이터 반영
        tableView.reloadData()
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
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        
        tableView.sectionHeaderTopPadding = 0
        tableView.sectionHeaderHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = ColorCase.black
        navigationItem.backButtonTitle = ""
        navigationItem.title = "SETTING"
    }
    
    @objc func headerBtnTapped(_ sender: UIButton) {
        pushVC(vc: ProfileNicknameViewController(nicknameViewType: .edit))
    }
}

// MARK: TableViewExtension
extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingCellTitle.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as! SettingTableViewCell
        cell.configureCell(SettingCellTitle.allCases[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SettingTableViewHeader.identifier) as! SettingTableViewHeader
        header.button.addTarget(self, action: #selector(headerBtnTapped), for: .touchUpInside)
        guard let userData = repository.readUserData() else { return header }
        header.configureHeaderView(profile: userData.userProfileImageName, nickname: userData.userName, joinDate: userData.joinDate)
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if SettingCellTitle.allCases[indexPath.row] == SettingCellTitle.cancel {
            showAlert(alertCase: .membershipCancel) { _ in
                self.repository.removeAllUserData()
                // 회원탈퇴 시 온보딩 화면으로 새로 시작
                let rootViewController = UINavigationController(rootViewController: OnboardingViewController())
                self.getNewScene(rootVC: rootViewController)
            }
        }
    }

}
