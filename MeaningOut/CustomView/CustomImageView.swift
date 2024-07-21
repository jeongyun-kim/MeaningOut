//
//  CustomImageView.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/15/24.
//

import UIKit

class CustomImageView: UIImageView {
    init(img: UIImage = .empty, radius: Resource.CornerRadiusCase = .none, bgColor: UIColor = Resource.ColorCase.white, content: UIImageView.ContentMode = .scaleAspectFill) {
        super.init(image: .empty)
        configureImageView(img, radius, bgColor, content)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureImageView(_ img: UIImage, _ radius: Resource.CornerRadiusCase, _ bgColor: UIColor, _ content: UIImageView.ContentMode) {
        layer.masksToBounds = true
        layer.cornerRadius = CGFloat(radius.rawValue)
        backgroundColor = bgColor
        contentMode = contentMode
        image = img
    }
}
