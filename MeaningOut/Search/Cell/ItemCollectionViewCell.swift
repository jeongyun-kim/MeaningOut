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

    private lazy var thumbnailImageView = CustomImageView(radius: .buttonOrImage, content: .scaleAspectFill)
    private lazy var mallNameLabel = CustomLabel(color: ColorCase.gray2, fontCase: FontCase.regular13)
    private lazy var titleLabel: UILabel = {
        let label = CustomLabel(fontCase: FontCase.regular14)
        label.numberOfLines = 2
        return label
    }()
    private lazy var priceLabel = CustomLabel(fontCase: FontCase.bold16)
    lazy var likeButton: UIButton = {
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
    
    func configureCell(_ item: resultItem, keyword: String) {
        thumbnailImageView.kf.setImage(with: item.url)
        mallNameLabel.text = item.mallName
        titleLabel.attributedText = configureTitleLabel(item.replacedTitle, keyword: keyword)
        priceLabel.text = item.priceString

        likeButton.setImage(item.likeBtnImage, for: .normal)
        likeButton.tintColor = item.likeBtnTintColor
        likeButton.backgroundColor = item.likeBtnBackgroundColor
    }
    
    private func configureTitleLabel(_ text: String, keyword: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        // 검색 키워드, 제목 모두 소문자로 바꿔서 비교 -> 대소문자 모두 대응가능
        attributedString.addAttribute(.backgroundColor, value: ColorCase.highlightColor, range: (text.lowercased() as NSString).range(of: keyword.lowercased()))
        
        return attributedString
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
