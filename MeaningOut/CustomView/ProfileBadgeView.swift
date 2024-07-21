//
//  ProfileBadgeView.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/16/24.
//

import UIKit
import SnapKit

class ProfileBadgeView: UIView {
    
    private let badgeImageView: UIImageView = {
        let imageView = CustomImageView(img: Resource.ImageCase.profileCamera!, bgColor: Resource.ColorCase.highlightColor, content: .scaleAspectFit)
        imageView.tintColor = Resource.ColorCase.white
        return imageView
    }()

    init(_ profileLayerSize: Resource.ProfileLayerSizeCase) {
        super.init(frame: .zero)
        setupHierarchy()
        configureLayout(profileLayerSize)
    }

    func setupHierarchy() {
        addSubview(badgeImageView)
    }
    
    private func configureLayout(_ profileLayerSize: Resource.ProfileLayerSizeCase) {
        let size = profileLayerSize.rawValue / 4
    
        snp.makeConstraints { make in
            make.size.equalTo(size)
        }
        
        badgeImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        
        backgroundColor = Resource.ColorCase.highlightColor
        layer.cornerRadius = CGFloat(size / 2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
