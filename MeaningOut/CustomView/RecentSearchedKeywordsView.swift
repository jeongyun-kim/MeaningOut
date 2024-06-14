//
//  RecentSearchedKeywordsView.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/14/24.
//

import UIKit

class RecentSearchedKeywordsView: UIView, SetupView {
   
    lazy var recentSearchLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFont.bold16
        label.text = "최근 검색"
        return label
    }()
    
    lazy var deleteAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("전체 삭제", for: .normal)
        button.setTitleColor(Color.primaryColor, for: .normal)
        button.titleLabel?.font = CustomFont.regular14
        button.addTarget(self, action: #selector(deleteBtnTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupConstraints()
    }
    
    func setupHierarchy() {
        addSubview(recentSearchLabel)
        addSubview(deleteAllButton)
    }
    
    func setupConstraints() {
        recentSearchLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading)
        }
        
        deleteAllButton.snp.makeConstraints { make in
            make.centerY.equalTo(recentSearchLabel.snp.centerY)
            make.trailing.equalTo(self.snp.trailing)
        }
    }

    
    @objc func deleteBtnTapped(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "searchKeywords")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
