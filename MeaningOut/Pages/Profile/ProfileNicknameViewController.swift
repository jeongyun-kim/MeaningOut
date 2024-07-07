//
//  ProfileNicknameViewController.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/13/24.
//

import UIKit
import SnapKit

class ProfileNicknameViewController: UIViewController, SetupView {
    init(nicknameViewType: ViewType = .setting) {
        super.init(nibName: nil, bundle: nil)
        self.nicknameViewType = nicknameViewType
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var nicknameViewType: ViewType = .setting
    private let repository = UserDataRepository()
    
    private let naviBorder = CustomBorder()
    // 프로필뷰
    private let profileLayerView = ProfileLayerView(.mainProfile)
    private let profileImageView = CustomImageView()
    private let badgeView = ProfileBadgeView(.mainProfile)
    private let profileButton = UIButton()
    
    private let nicknameTextField = NicknameTextField(placeholderType: .nickname)
    private let textFieldBorder = CustomBorder()
    private let nicknameCheckLabel = CustomLabel(color: ColorCase.primaryColor, fontCase: FontCase.regular13)
    private let confirmButton = OnboardingButton(title: "완료")
    
    private var nicknameCheck: NicknameCheckType = .wrongNicknameCnt {
        didSet {
            nicknameCheckLabel.text = nicknameCheck.rawValue
            
            switch nicknameCheck {
            case .confirm:
                navigationItem.rightBarButtonItem?.isEnabled = true
                confirmButton.isEnabled = true
            case .empty, .wrongNicknameCnt, .containsNumber, .containsSpecialCharacter:
                navigationItem.rightBarButtonItem?.isEnabled = false
                confirmButton.isEnabled = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupConstraints()
        setupUI()
        addActions()
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
            make.trailing.bottom.equalTo(profileLayerView).inset(ProfileLayerSizeCase.mainProfile.inset)
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
        
        navigationController?.navigationBar.tintColor = ColorCase.black
        navigationItem.title = nicknameViewType.rawValue
        navigationItem.backButtonTitle = ""
        
        if nicknameViewType == .edit {
            guard let user = repository.readUserData() else { return }
            nicknameTextField.text = user.userName
            confirmButton.isHidden = true
            let rightBarItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveData))
            navigationItem.rightBarButtonItem = rightBarItem
        }
    }
    
    private func configureProfileImageView() {
        // 프로필 선택화면에서 선택하고 넘어온 상태라면
        if let profile = ProfileImage.tempSelectedProfileImage {
            let imageName = profile.imageName
            profileImageView.image = UIImage(named: imageName)
        } else { // 온보딩 화면에서 넘어온 상태라면
            let imageName = ProfileImage.randomImage.imageName
            profileImageView.image = UIImage(named: imageName)
            ProfileImage.tempSelectedProfileImage = ProfileImage(imageName: imageName)
        }
    }
    
    private func getJoinDate() -> String {
        let dateFormatter = DateFormatter()
        let localeID = Locale.preferredLanguages.first
        let deviceLocale = Locale(identifier: localeID ?? "ko-kr").languageCode
        dateFormatter.locale = Locale(identifier: deviceLocale ?? "ko-kr")
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "YYYY.MM.dd 가입"
        return dateFormatter.string(from: Date())
    }
    
    func addActions() {
        nicknameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        confirmButton.addTarget(self, action: #selector(confirmBtnTapped), for: .touchUpInside)
        profileButton.addTarget(self, action: #selector(profileBtnTapped), for: .touchUpInside)
    }
    
    @objc func saveData() {
        guard let name = nicknameTextField.text else { return }
        guard let profileImage = ProfileImage.tempSelectedProfileImage else { return }
        
        if let userData = repository.readUserData() {
            repository.updateUserData(value: ["id": userData.id, "userName": name, "userProfileImageName": profileImage.imageName])
        } else {
            repository.createUserData(name: name, profileImage: profileImage.imageName, joinDate: getJoinDate())
        }

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
    
    private func validateNickname(_ text: String) throws ->  Bool {
        // 숫자가 있는 상황에서 @를 입력할 경우에 숫자가 포함되서는 안된다는 메시지만 출력됨
        // 이를 방지하기 위해 마지막 문자까지 비교
        guard let lastChr = text.last else {
            throw NicknameErrorCase.empty
        }
        // 마지막 글자가 특수문자인지 확인
        guard !["$", "%", "@", "#"].contains(lastChr) else {
            throw NicknameErrorCase.containsSpecialCharacter
        }
        guard Int(String(describing: lastChr)) == nil else {
            throw NicknameErrorCase.containsNumber
        }
        
        // 전체 문자 확인
        // 공백 모두 제거한 문자열의 길이
        let removeWhiteSpaceCnt = getRemovedWhiteSpaceStringLength(text)
        // 닉네임에 숫자가 들어있는지
        let isContainsNumber = text.range(of: NicknameRegex.number, options: .regularExpression) != nil
        // 닉네임에 # $ @ % 가 들어있는지
        let isContainsSpecialChr = text.range(of: NicknameRegex.specialCharacter, options: .regularExpression) != nil
        
        guard removeWhiteSpaceCnt >= 2 && removeWhiteSpaceCnt <= 10 else {
            throw NicknameErrorCase.wrongNicknameCnt
        }
        guard !isContainsNumber else {
            throw NicknameErrorCase.containsNumber
        }
        guard !isContainsSpecialChr else {
            throw NicknameErrorCase.containsSpecialCharacter
        }
        return true
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        guard let text = nicknameTextField.text else { return }
        do {
            let _ = try validateNickname(text)
            nicknameCheck = .confirm
        } catch {
            switch error {
            case NicknameErrorCase.empty:
                nicknameCheck = .empty
            case NicknameErrorCase.wrongNicknameCnt:
                nicknameCheck = .wrongNicknameCnt
            case NicknameErrorCase.containsNumber:
                nicknameCheck = .containsNumber
            case NicknameErrorCase.containsSpecialCharacter:
                nicknameCheck = .containsSpecialCharacter
            default:
                break
            }       
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
