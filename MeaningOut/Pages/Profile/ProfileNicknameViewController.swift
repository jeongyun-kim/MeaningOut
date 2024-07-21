//
//  ProfileNicknameViewController.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/13/24.
//

import UIKit
import SnapKit

class ProfileNicknameViewController: UIViewController, SetupView {
    private let vm: ProfileNicknameViewModel = ProfileNicknameViewModel()
    init(nicknameViewType: Resource.ViewType = .setting) {
        super.init(nibName: nil, bundle: nil)
        self.nicknameViewType = nicknameViewType
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var nicknameViewType: Resource.ViewType = .setting
    
    private let naviBorder = CustomBorder()
    // 프로필뷰
    private let profileLayerView = ProfileLayerView(.mainProfile)
    private let profileImageView = CustomImageView()
    private let badgeView = ProfileBadgeView(.mainProfile)
    private let profileButton = UIButton()
    
    private let nicknameTextField = NicknameTextField(placeholderType: .nickname)
    private let textFieldBorder = CustomBorder()
    private let nicknameCheckLabel = CustomLabel(color: Resource.ColorCase.highlightColor, fontCase: Resource.FontCase.regular13)
    private let confirmButton = OnboardingButton(title: "완료")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupConstraints()
        setupUI()
        addActions()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureProfileImageView()
    }
    
    func setupHierarchy() {
        view.addSubview(naviBorder)
        view.addSubview(profileLayerView)
        profileLayerView.addSubview(profileImageView)
        view.addSubview(badgeView)
        view.addSubview(profileButton)
        view.addSubview(nicknameTextField)
        view.addSubview(textFieldBorder)
        view.addSubview(nicknameCheckLabel)
        view.addSubview(confirmButton)
    }
    
    func setupConstraints() {
        naviBorder.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        profileLayerView.snp.makeConstraints { make in
            make.top.equalTo(naviBorder.snp.bottom).offset(16)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        badgeView.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(profileLayerView).inset(Resource.ProfileLayerSizeCase.mainProfile.inset)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalTo(profileLayerView.snp.centerX)
            make.bottom.equalTo(profileLayerView.snp.bottom)
            make.size.equalTo(profileLayerView.snp.width).multipliedBy(0.9)
        }
        
        profileButton.snp.makeConstraints { make in
            make.edges.equalTo(profileLayerView)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(profileLayerView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(45)
        }
        
        textFieldBorder.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(nicknameTextField)
            make.top.equalTo(nicknameTextField.snp.bottom)
        }
        
        nicknameCheckLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(textFieldBorder)
            make.top.equalTo(textFieldBorder.snp.bottom).offset(8)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(nicknameTextField)
            make.top.equalTo(textFieldBorder.snp.bottom).offset(50)
        }
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        confirmButton.isEnabled = false
        
        navigationController?.navigationBar.tintColor = Resource.ColorCase.black
        navigationItem.title = nicknameViewType.rawValue
        navigationItem.backButtonTitle = ""
        // 편집모드라면 ViewModel의 편집모드인지에 대해 묻는 변수(isEditMode) 값 true로
        if nicknameViewType == .edit {
            vm.isEditMode.value = true
        }
    }
    
    private func configureProfileImageView() {
        // 프로필 선택화면에서 선택하고 넘어온 상태라면
        if let profile = ProfileImage.tempSelectedProfileImage {
            let imageName = profile.imageName
            profileImageView.image = UIImage(named: imageName)
        } else { // 온보딩 화면에서 넘어온 상태라면
            let imageName = ProfileImage().randomImage.imageName
            profileImageView.image = UIImage(named: imageName)
            ProfileImage.tempSelectedProfileImage = ProfileImage(imageName: imageName)
        }
    }
    
    func addActions() {
        nicknameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        confirmButton.addTarget(self, action: #selector(confirmBtnTapped), for: .touchUpInside)
        profileButton.addTarget(self, action: #selector(profileBtnTapped), for: .touchUpInside)
    }
    
    @objc func saveData() {
        guard let name = nicknameTextField.text else { return }
        guard let profileImage = ProfileImage.tempSelectedProfileImage else { return }
        let nameKey = Resource.UserDataKeyCase.userName.rawValue
        let profileKey = Resource.UserDataKeyCase.userProfileImageName.rawValue
        vm.saveBtnTapped.value = [nameKey: name, profileKey: profileImage.imageName]
        if nicknameViewType == .edit {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func profileBtnTapped(_ sender: UIButton) {
        guard let tempProfileImage = ProfileImage.tempSelectedProfileImage else { return }
        pushVC(vc: ProfileViewController(tempProfileImage: tempProfileImage, profileViewType: nicknameViewType))
    }
    
    @objc func confirmBtnTapped(_ sender: UIButton) {
        saveData()
        getNewScene(rootVC: TabBarController())
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        guard let text = nicknameTextField.text else { return }
        vm.inputNicknameForCheck.value = text
    }

    
    private func bind() {
        // ViewModel의 닉네임 유효성 결과에 따라 다르게 처리
        vm.outputNicknameCheckType.bind { nicknameCheckType in
            self.nicknameCheckLabel.text = nicknameCheckType.rawValue
            
            switch nicknameCheckType {
            case .confirm:
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                self.confirmButton.isEnabled = true
            default:
                self.navigationItem.rightBarButtonItem?.isEnabled = false
                self.confirmButton.isEnabled = false
            }
        }
        
        // ViewModel에서 받아온 userData를 이용해 편집 시 기본 설정
        vm.outputUserData.bind(handler: { user in
            guard let user else { return }
            self.nicknameTextField.text = user.userName // 닉네임 텍스트필드에 현재 닉네임 넣어주기
            self.confirmButton.isHidden = true // 저장 버튼 지우기
            let rightBarItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(self.saveData))
            self.navigationItem.rightBarButtonItem = rightBarItem // 네비게이션 저장 버튼 생성하기
            self.vm.inputNicknameForCheck.value = user.userName // 닉네임 체크해주는 결과값을 위해 현재 닉네임 보내기 -> 바로 위의 vm.outputNicknameCheckType.bind로 돌아옴
        }, initRun: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
