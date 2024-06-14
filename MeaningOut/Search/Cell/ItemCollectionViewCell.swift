//
//  ItemCollectionViewCell.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/14/24.
//

import UIKit
import SnapKit
import Kingfisher

class ItemCollectionViewCell: UICollectionViewCell, SetupView {
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = CGFloat(CornerRadiusCase.image.rawValue)
        imageView.backgroundColor = .lightGray
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var mallNameLabel: UILabel = {
        let label = UILabel()
        label.font = FontCase.regular13
        label.text = "네이버"
        label.textColor = ColorCase.gray2
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = FontCase.regular14
        label.numberOfLines = 2
        label.text = "애플 레트로 키캡 XDA PBT 한무무 기계식 키보드"
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = FontCase.bold16
        label.text = "22,800원"
        return label
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = CGFloat(CornerRadiusCase.button.rawValue)
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
            make.height.equalTo(contentView.snp.height).multipliedBy(0.7)
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
            make.bottom.lessThanOrEqualTo(contentView.safeAreaLayoutGuide).inset(12)
        }
    }
    
    func configureCell(_ item: item) {
        thumbnailImageView.kf.setImage(with: item.url)
        mallNameLabel.text = item.mallName
        titleLabel.text = item.replacedTitle
        priceLabel.text = item.price
        

        likeButton.setImage(item.likeImage, for: .normal)
        likeButton.tintColor = item.likeTintColor
        likeButton.backgroundColor = item.likeBackgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
