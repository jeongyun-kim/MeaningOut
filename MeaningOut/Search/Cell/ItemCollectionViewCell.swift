//
//  ItemCollectionViewCell.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/14/24.
//

import UIKit
import SnapKit
import Kingfisher

class ItemCollectionViewCell: BaseItemCollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
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
