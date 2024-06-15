//
//  ProfileCollectionViewCell.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/14/24.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell, SetupView {
    lazy var view = UIView()
    
    lazy var imageView = CustomImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupConstraints()
        configureLayout()
    }
    
    func setupHierarchy() {
        contentView.addSubview(view)
        view.addSubview(imageView)
    }
    
    func setupConstraints() {
        view.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.snp.bottom)
            make.size.equalTo(view.snp.width).multipliedBy(0.9)
        }
    }
    
    private func configureLayout() {
        view.layer.cornerRadius = contentView.frame.width / 2
        view.layer.masksToBounds = true
    }
    
    // 지금 들어온 이미지가 현재 선택되어있는 이미지랑 같은 이미지라면 true
    func configureCell(_ data: ProfileImage, nowData: ProfileImage) {
        if data.imageName == nowData.imageName {
            setSelected(true)
        } else {
            setSelected(false)
        }
        imageView.image = UIImage(named: data.imageName)
    }
    
    // 선택된 상태인지 아닌지에 따라 다르게
    private func setSelected(_ selected: Bool) {
        if selected {
            view.alpha = 1
            view.layer.borderColor = ColorCase.primaryColor.cgColor
            view.layer.borderWidth = BorderCase.selected
        } else {
            view.alpha = 0.5
            view.layer.borderColor = ColorCase.gray2.cgColor
            view.layer.borderWidth = BorderCase.deselected
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
