//
//  SettingTableViewHeader.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/15/24.
//

import UIKit

class SettingTableViewHeader: UITableViewHeaderFooterView, SetupView {
    let button = UIButton()
    private let profileLayerView = ProfileLayerView(.headerProfile)
    private let badgeImage = ProfileBadgeView(.headerProfile)
    private let profileImageView = CustomImageView(bgColor: ColorCase.white)
    private let userInfoLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        return stackView
    }()
    private let nicknameLabel = CustomLabel(fontCase: FontCase.bold20)
    private let dateLabel = CustomLabel(color: ColorCase.gray2, fontCase: FontCase.regular14)
    private let goEditImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = ImageCase.next
        imageView.tintColor = ColorCase.gray2
        return imageView
    }()
    private let border = CustomBorder(color: ColorCase.black)

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupConstraints()
    }
    
    func configureHeaderView(profile: String, nickname: String, joinDate: String) {
        profileImageView.image = UIImage(named: profile)
        nicknameLabel.text = nickname
        dateLabel.text = joinDate
    }
    
    func setupHierarchy() {
        contentView.addSubview(profileLayerView)
        profileLayerView.addSubview(profileImageView)
        contentView.addSubview(userInfoLabelStackView)
        [nicknameLabel, dateLabel].forEach {
            userInfoLabelStackView.addArrangedSubview($0)
        }
        contentView.addSubview(goEditImageView)
        contentView.addSubview(border)
        contentView.addSubview(button)
        contentView.addSubview(badgeImage)
    }

    func setupConstraints() {
        profileLayerView.snp.makeConstraints { make in
            make.verticalEdges.lessThanOrEqualTo(20)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
        }
        
        badgeImage.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(profileLayerView).inset(ProfileLayerSizeCase.headerProfile.inset)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.size.equalTo(profileLayerView.snp.width).multipliedBy(0.9)
            make.bottom.equalTo(profileLayerView.snp.bottom)
            make.centerX.equalTo(profileLayerView.snp.centerX)
        }
        
        userInfoLabelStackView.snp.makeConstraints { make in
            make.leading.equalTo(profileLayerView.snp.trailing).offset(24)
            make.centerY.equalTo(profileLayerView.snp.centerY)
        }
        
        goEditImageView.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(userInfoLabelStackView.snp.trailing).offset(16)
            make.centerY.equalTo(userInfoLabelStackView.snp.centerY)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.size.equalTo(15)
        }
        
        button.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        border.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
