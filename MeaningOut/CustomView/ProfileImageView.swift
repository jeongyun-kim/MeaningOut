//
//  ProfileImageView.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/13/24.
//

import UIKit
import SnapKit


class ProfileImageView: UIImageView {
    init(profileImage: ProfileImage) {
        super.init(frame: .zero)
        configureProfileImageView(profileImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureProfileImageView(_ profileImage: ProfileImage) {
        image = UIImage(named: profileImage.imageName)
        contentMode = .scaleAspectFit
        layer.masksToBounds = true
    }
}
