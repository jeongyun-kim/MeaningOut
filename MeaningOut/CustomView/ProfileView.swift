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
        return imageView
    }()
    
    init(profile: ProfileImage) {
        super.init(frame: .zero)
        layer.masksToBounds = true
        self.addSubview(imageView)
        setupConstraints()
        configureProfileImageView(profile)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints(){
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom)
            make.size.equalTo(self.snp.width).multipliedBy(0.9)
        }
    }
    
    private func configureProfileImageView(_ profileImage: ProfileImage) {
        imageView.image = UIImage(named: profileImage.imageName)
        layer.borderColor = Color.primaryColor.cgColor
        layer.borderWidth = Border.selected
    }
}
