//
//  CustomImageView.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/15/24.
//

import UIKit

class CustomImageView: UIImageView {
    init(img: UIImage = .empty, radius: CornerRadiusCase = .none, bgColor: UIColor = ColorCase.white) {
        super.init(image: .empty)
        configureImageView(img, radius, bgColor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureImageView(_ img: UIImage, _ radius: CornerRadiusCase, _ bgColor: UIColor) {
        layer.masksToBounds = true
        layer.cornerRadius = CGFloat(radius.rawValue)
        backgroundColor = bgColor
        contentMode = .scaleAspectFill
        image = img
    }
}
