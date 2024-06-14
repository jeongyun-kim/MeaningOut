//
//  EmptyView.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/14/24.
//

import UIKit
import SnapKit

class EmptyView: UIView, SetupView {

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = Images.empty
        return imageView
    }()
    
    lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "최근 검색어가 없어요"
        label.font = CustomFont.bold16
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupHierarchy()
        setupConstraints()
    }
    
    func setupHierarchy() {
        addSubview(imageView)
        addSubview(resultLabel)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY).offset(-70)
            make.size.equalTo(250)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.centerX.equalTo(imageView.snp.centerX)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
