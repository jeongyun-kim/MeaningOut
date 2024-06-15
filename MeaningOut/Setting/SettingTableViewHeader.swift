//
//  SettingTableViewHeader.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/15/24.
//

import UIKit

class SettingTableViewHeader: UITableViewHeaderFooterView, SetupView {
    
    lazy var ud = UserDefaultsManager.self
    
    lazy var profileLayerView = ProfileLayerView(80)
    
    lazy var profileImageView = CustomImageView(img: UIImage(named: ud.userProfileImage)!)
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    lazy var nicknameLabel = CustomLabel(title: ud.userName, fontCase: FontCase.bold20)
    
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
    
    func setupHierarchy() {
        contentView.addSubview(profileLayerView)
        profileLayerView.addSubview(profileImageView)
        contentView.addSubview(stackView)
        [nicknameLabel, dateLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        contentView.addSubview(imageView)
        contentView.addSubview(border)
    }
    
    // 다시 잡기
    func setupConstraints() {
        profileLayerView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.size.equalTo(profileLayerView.snp.width)
            make.bottom.equalTo(profileImageView.snp.bottom)
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
