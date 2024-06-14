//
//  TagCollectionViewCell.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/14/24.
//

import UIKit
import SnapKit

class TagCollectionViewCell: UICollectionViewCell, SetupView {
    let tagLabel: UILabel = {
        let label = PaddingLabel(frame: .zero)
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        label.layer.borderWidth = 1
        label.layer.borderColor = Color.gray3.cgColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupConstraints()
    }
    
    func setupHierarchy() {
        contentView.addSubview(tagLabel)
    }
    
    func setupConstraints() {
        tagLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    func configureCell(_ title: String) {
        let attributedTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: CustomFont.regular13, NSAttributedString.Key.foregroundColor: Color.black])
        tagLabel.attributedText = attributedTitle
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                tagLabel.backgroundColor = Color.gray1
                tagLabel.textColor = Color.white
            } else {
                tagLabel.backgroundColor = Color.white
                tagLabel.textColor = Color.black
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
