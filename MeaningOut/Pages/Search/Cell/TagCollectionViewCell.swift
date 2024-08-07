//
//  TagCollectionViewCell.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/14/24.
//

import UIKit
import SnapKit

class TagCollectionViewCell: UICollectionViewCell, SetupView {
    private let tagLabel: UILabel = {
        let label = PaddingLabel(frame: .zero)
        label.layer.cornerRadius = CGFloat(Resource.CornerRadiusCase.label.rawValue)
        label.clipsToBounds = true
        label.layer.borderWidth = 1
        label.layer.borderColor = Resource.ColorCase.gray3.cgColor
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
        let attributedTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: Resource.FontCase.regular13, NSAttributedString.Key.foregroundColor: Resource.ColorCase.black])
        tagLabel.attributedText = attributedTitle
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                tagLabel.backgroundColor = Resource.ColorCase.gray1
                tagLabel.textColor = Resource.ColorCase.white
            } else {
                tagLabel.backgroundColor = Resource.ColorCase.white
                tagLabel.textColor = Resource.ColorCase.black
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
