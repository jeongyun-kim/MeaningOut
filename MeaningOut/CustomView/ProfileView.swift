//
//  ProfileView.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/13/24.
//

import UIKit
import SnapKit

enum ProfileSelectType {
    case deselected
    case selected
}

class ProfileView: UIView {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.snp.makeConstraints { make in
            make.size.equalTo(110)
        }
        return imageView
    }()
    
    init(profile: ProfileImage, type: ProfileSelectType) {
        super.init(frame: .zero)
        layer.masksToBounds = true
        self.addSubview(imageView)
        setupConstraints()
        configureProfileImageView(profile, type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints(){
        snp.makeConstraints { make in
            make.size.equalTo(120)
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
    
    private func configureProfileImageView(_ profileImage: ProfileImage, _ type: ProfileSelectType) {
        imageView.image = UIImage(named: profileImage.imageName)
       
        layer.borderWidth = Border.selected
        layer.cornerRadius = 60
        switch type {
        case .deselected:
            imageView.alpha = 0.5
            layer.borderColor = Color.gray2.cgColor
        case .selected:
            imageView.alpha = 1
            layer.borderColor = Color.primaryColor.cgColor
        }
    }
}
