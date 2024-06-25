//
//  OnboardingViewController.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/13/24.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController, SetupView {
    
    private let onboardingLabel = CustomLabel(title: "MeaningOut", color: ColorCase.primaryColor, fontCase: FontCase.bold48)
    private let onboardingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = ImageCase.launch
        return imageView
    }()
    private let startButton = OnboardingButton(title: "시작하기")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupConstraints()
        setupUI()
        addActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 프로필 설정 화면에서 온보딩 화면으로 다시 오면 선택해뒀던 프로필 이미지 제거 
        ProfileImage.tempSelectedProfileImage = nil
    }
    
    func setupHierarchy() {
        view.addSubview(onboardingLabel)
        view.addSubview(onboardingImageView)
        view.addSubview(startButton)
    }
    
    func setupConstraints() {
        onboardingImageView.snp.makeConstraints { make in
            make.width.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.8)
            make.height.equalTo(onboardingImageView.snp.width)
            make.center.equalTo(view)
        }
        
        onboardingLabel.snp.makeConstraints { make in
            make.bottom.equalTo(onboardingImageView.snp.top).offset(-50)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        startButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = ColorCase.black
    }
    
    func addActions() {
        startButton.addTarget(self, action: #selector(startBtnTapped), for: .touchUpInside)
    }
    
    @objc func startBtnTapped(_ sender: UIButton) {
        let vc = ProfileNicknameViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
