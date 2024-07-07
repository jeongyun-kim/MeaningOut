//
//  BaseCollectionViewCell.swift
//  MeaningOut
//
//  Created by 김정윤 on 7/7/24.
//

import UIKit
import SnapKit

class BaseItemCollectionViewCell: UICollectionViewCell {
    
    let thumbnailImageView = CustomImageView(radius: .buttonOrImage, content: .scaleAspectFill)
    let mallNameLabel = CustomLabel(color: ColorCase.gray2, fontCase: FontCase.regular13)
    let titleLabel: UILabel = {
        let label = CustomLabel(fontCase: FontCase.regular14)
        label.numberOfLines = 2
        return label
    }()
    let priceLabel = CustomLabel(fontCase: FontCase.bold16)
    let likeButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = CGFloat(CornerRadiusCase.buttonOrImage.rawValue)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupConstraints()
    }
    
    func setupHierarchy() {
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(likeButton)
        contentView.addSubview(mallNameLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
    }
    
    func setupConstraints() {
        thumbnailImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.65)
        }
        
        likeButton.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(thumbnailImageView).inset(8)
            make.size.equalTo(40)
        }
        
        mallNameLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(4)
            make.leading.equalTo(thumbnailImageView.snp.leading)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mallNameLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(thumbnailImageView)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(titleLabel.snp.leading)
            make.bottom.lessThanOrEqualTo(contentView.safeAreaLayoutGuide).inset(4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
