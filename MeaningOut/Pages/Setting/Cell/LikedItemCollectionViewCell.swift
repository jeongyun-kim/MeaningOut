//
//  LikedItemCollectionViewCell.swift
//  MeaningOut
//
//  Created by 김정윤 on 7/7/24.
//

import UIKit
import SnapKit
import Kingfisher

final class LikedItemCollectionViewCell: BaseItemCollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        likeButton.setImage(Resource.ImageCase.like_selected, for: .normal)
        likeButton.tintColor = Resource.ColorCase.primaryColor
        likeButton.backgroundColor = Resource.ColorCase.white
    }
    
    func configureCell(_ data: Item) {
        titleLabel.text = data.title
        priceLabel.text = data.price
        mallNameLabel.text = data.mallName
        guard let url = URL(string: data.imagePath) else { return }
        thumbnailImageView.kf.setImage(with: url)
    }
}
