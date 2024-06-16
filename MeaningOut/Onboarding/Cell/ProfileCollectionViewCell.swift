//
//  ProfileCollectionViewCell.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/14/24.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell, SetupView {
    lazy var profileLayerView = ProfileLayerView(.zero)
    
    lazy var imageView = CustomImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupConstraints()
        configureLayout()
    }
    
    func setupHierarchy() {
        contentView.addSubview(profileLayerView)
        profileLayerView.addSubview(imageView)
    }
    
    func setupConstraints() {
        profileLayerView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(profileLayerView.snp.centerX)
            make.bottom.equalTo(profileLayerView.snp.bottom)
            make.size.equalTo(profileLayerView.snp.width).multipliedBy(0.9)
        }
    }
    
    private func configureLayout() {
        profileLayerView.layer.cornerRadius = contentView.frame.width / 2
        profileLayerView.layer.masksToBounds = true
    }
    
    // 지금 들어온 이미지가 현재 선택되어있는 이미지랑 같은 이미지라면 true
    func configureCell(_ data: ProfileImage, nowSelectedProfileImage: ProfileImage) {
        if data.imageName == nowSelectedProfileImage.imageName {
            setSelected(true)
        } else {
            setSelected(false)
        }
        imageView.image = UIImage(named: data.imageName)
    }
    
    // 선택된 상태인지 아닌지에 따라 다르게
    private func setSelected(_ selected: Bool) {
        if selected {
            profileLayerView.alpha = 1
            profileLayerView.layer.borderColor = ColorCase.primaryColor.cgColor
            profileLayerView.layer.borderWidth = BorderCase.selected
        } else {
            profileLayerView.alpha = 0.5
            profileLayerView.layer.borderColor = ColorCase.gray2.cgColor
            profileLayerView.layer.borderWidth = BorderCase.deselected
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
