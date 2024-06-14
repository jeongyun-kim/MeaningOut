//
//  SearchKeywordsTableViewCell.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/14/24.
//

import UIKit
import SnapKit

class SearchKeywordsTableViewCell: UITableViewCell, SetupView {

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageCase.clock
        imageView.tintColor = ColorCase.black
        return imageView
    }()
    
    private lazy var keywordLabel: UILabel = {
        let label = UILabel()
        label.font = FontCase.regular14
        return label
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageCase.delete, for: .normal)
        button.imageView?.tintColor = ColorCase.black
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupConstraints()
        configureLayout()
    }
    
    func setupHierarchy() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(keywordLabel)
        contentView.addSubview(deleteButton)
    }
    
    func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(24)
            make.width.equalTo(iconImageView.snp.height)
            make.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(12)
        }
        
        keywordLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(12)
            make.centerY.equalTo(iconImageView.snp.centerY)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.leading.equalTo(keywordLabel.snp.trailing).offset(8)
            make.centerY.equalTo(keywordLabel.snp.centerY)
            make.trailing.equalTo(contentView.snp.trailing).inset(24)
            make.size.equalTo(iconImageView.snp.size)
        }
    }
    
    private func configureLayout() {
        selectionStyle = .none
    }
    
    func configureCell(_ keyword: String) {
        keywordLabel.text = keyword
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
