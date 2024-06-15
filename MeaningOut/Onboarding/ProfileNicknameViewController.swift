//
//  ProfileNicknameViewController.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/13/24.
//

import UIKit
import SnapKit

class ProfileNicknameViewController: UIViewController, SetupView {
    
    lazy var nicknameViewType: ViewType = .setting
    
    lazy var ud = UserDefaultsManager.self
    
    private lazy var naviBorder = CustomBorder()
    
    // 현재 프로필에 걸려있는 프로필 이미지
    // 뷰를 불러올 때에는 찐데이터 -> 저장 전까지는 임시데이터
    //private lazy var profileImage = ProfileImage.tempSelectedImage
    
    // 프로필뷰
    private lazy var profileLayerView = ProfileLayerView(120)
    
    private lazy var profileImageView = CustomImageView()

    private lazy var nicknameTextField = NicknameTextField(placeholderType: .nickname)
    
    private lazy var textFieldBorder = CustomBorder()
    
    private lazy var checkLabel = CustomLabel(color: ColorCase.primaryColor, fontCase: FontCase.regular13)
    
    private lazy var confirmButton = OnboardingButton(title: "완료")
    
    private lazy var profileButton = UIButton()
    
    private lazy var nicknameCheck: NicknameCheckType = .wrongNicknameCnt {
        didSet {
            checkLabel.text = nicknameCheck.rawValue
            
            switch nicknameCheck {
            case .confirm:
                navigationItem.rightBarButtonItem?.isEnabled = true
                confirmButton.isEnabled = true
            case .wrongNicknameCnt, .containsNumber, .containsSpecialCharacter:
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
        profileImageView.image = UIImage(named: ProfileImage.tempSelectedImage.imageName)
        
        if nicknameViewType == .edit {
            nicknameTextField.text = ud.userName
            confirmButton.isHidden = true
        }
    }
    
    func setupHierarchy() {
        view.addSubview(naviBorder)
        view.addSubview(profileLayerView)
        profileLayerView.addSubview(profileImageView)
        view.addSubview(profileButton)
        view.addSubview(nicknameTextField)
        view.addSubview(textFieldBorder)
        view.addSubview(checkLabel)
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
        
        checkLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(textFieldBorder)
            make.top.equalTo(textFieldBorder.snp.bottom).offset(8)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(nicknameTextField)
            make.top.equalTo(textFieldBorder.snp.bottom).offset(50)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        confirmButton.isEnabled = false
        
        navigationController?.navigationBar.tintColor = ColorCase.black
        navigationItem.title = nicknameViewType.rawValue
        navigationItem.backButtonTitle = ""
        if nicknameViewType == .edit {
            let rightBarItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveData))
            navigationItem.rightBarButtonItem = rightBarItem
        }
    }
    
    func addActions() {
        nicknameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        confirmButton.addTarget(self, action: #selector(confirmBtnTapped), for: .touchUpInside)
        profileButton.addTarget(self, action: #selector(profileImageTapped), for: .touchUpInside)
    }
    
    @objc func saveData() {
        ud.userName = nicknameTextField.text!
        ud.userProfileImage = ProfileImage.tempSelectedImage.imageName

        if nicknameViewType == .edit {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func profileImageTapped(_ sender: UIButton) {
        let vc = ProfileViewController()
        vc.tempProfileImage = ProfileImage.tempSelectedImage
        vc.profileViewType = .edit
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func confirmBtnTapped(_ sender: UIButton) {
        ud.isUser = true
        saveData()
        getNewScene(rootVC: TabBarController())
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        guard let text = nicknameTextField.text else { return }
        
        // 숫자가 있는 상황에서 @를 입력할 경우에 숫자가 포함되서는 안된다는 메시지만 출력됨
        // 이를 방지하기 위해 마지막 문자까지 비교
        guard let lastChr = text.last else { return }
        
        // 마지막 글자가 특수문자인지 확인
        if ["$", "%", "@", "#"].contains(lastChr) {
            nicknameCheck = .containsSpecialCharacter
            //configureCheckLabel(.containsSpecialCharacter)
            return
        }
        
        // 마지막 글자가 숫자인지 확인
        if Int(String(describing: lastChr)) != nil {
            nicknameCheck = .containsNumber
            //configureCheckLabel(.containsNumber)
            return
        }
        
        // 전체 문자 확인
        // 공백 모두 제거한 문자열의 길이
        let removeWhiteSpaceCnt = text.components(separatedBy: " ").joined().count
        // 닉네임에 숫자가 들어있는지
        let isContainsNumber = text.range(of: NicknameRegex.number, options: .regularExpression) != nil
        // 닉네임에 # $ @ % 가 들어있는지
        let isContainsSpecial = text.range(of: NicknameRegex.specialCharacter, options: .regularExpression) != nil
        
        if removeWhiteSpaceCnt < 2 || removeWhiteSpaceCnt > 10 { // 문자열 길이
            nicknameCheck = .wrongNicknameCnt
            //configureCheckLabel(.wrongNicknameCnt)
        } else if  isContainsNumber  { // 숫자
            nicknameCheck = .containsNumber
            //configureCheckLabel(.containsNumber)
        } else if isContainsSpecial { // 특수문자
            nicknameCheck = .containsSpecialCharacter
            //configureCheckLabel(.containsSpecialCharacter)
        } else {
            nicknameCheck = .confirm
            //configureCheckLabel(.confirm)
        }
    }
}
