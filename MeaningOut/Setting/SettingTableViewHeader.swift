//
//  SettingTableViewHeader.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/15/24.
//

import UIKit

class SettingTableViewHeader: UITableViewHeaderFooterView, SetupView {
    
    lazy var ud = UserDefaultsManager.self
    
    lazy var button = UIButton()
    
    lazy var profileLayerView = ProfileLayerView(80)
    
    lazy var profileImageView = CustomImageView(bgColor: ColorCase.white)
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var nicknameLabel = CustomLabel(fontCase: FontCase.bold20)
    
    lazy var dateLabel = CustomLabel(color: ColorCase.gray2, fontCase: FontCase.regular14)
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = ImageCase.next
        imageView.tintColor = ColorCase.gray2
        return imageView
    }()
    
    lazy var border = CustomBorder(color: ColorCase.black)

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
        contentView.addSubview(stackView)
        [nicknameLabel, dateLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        contentView.addSubview(imageView)
        contentView.addSubview(border)
        contentView.addSubview(button)
    }
    
    // 다시 잡기
    func setupConstraints() {
        profileLayerView.snp.makeConstraints { make in
            make.verticalEdges.lessThanOrEqualTo(20)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.size.equalTo(profileLayerView.snp.width).multipliedBy(0.9)
            make.bottom.equalTo(profileLayerView.snp.bottom)
            make.centerX.equalTo(profileLayerView.snp.centerX)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(profileLayerView.snp.trailing).offset(24)
            make.centerY.equalTo(profileLayerView.snp.centerY)
        }
        
        imageView.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(stackView.snp.trailing).offset(16)
            make.centerY.equalTo(stackView.snp.centerY)
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
