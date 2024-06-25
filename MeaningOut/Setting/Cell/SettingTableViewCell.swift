//
//  SettingTableViewCell.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/15/24.
//

import UIKit
import SnapKit

class SettingTableViewCell: UITableViewCell, SetupView {
    private let ud = UserDefaultsManager.shared
    
    private let titleLabel = CustomLabel(title: "", fontCase: FontCase.regular14)
    private let border = CustomBorder(color: ColorCase.black)
    private let likeButton: UIButton = {
        let button = UIButton(configuration: .plain())
        button.setImage(ImageCase.like_selected, for: .normal)
        button.tintColor = ColorCase.black
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupConstraints()
        configureLayout()
    }
    
    // 셀 재사용될 때 호출
    override func prepareForReuse() {
        likeButton.isHidden = false
    }
    
    func setupHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(border)
        contentView.addSubview(likeButton)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(12)
        }
        
        border.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(contentView.snp.bottom)
        }
        
        likeButton.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(10)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
    }
    
    private func configureLayout() {
        selectionStyle = .none
    }

    func configureCell(_ data: SettingCellTitle) {
        titleLabel.text = data.rawValue
        
        if data == .likeList {
            likeButton.setAttributedTitle(getAttributedLikeCntTitle(), for: .normal)
        } else {
            likeButton.isHidden = true
        }
    }
    
    private func getAttributedLikeCntTitle() -> NSAttributedString {
        let text = "\(ud.likeCnt)개" // 상품 개수
        let title = "\(text)의 상품" // 찐타이틀
        let attributedString = NSMutableAttributedString(string: title)
        
        // 상품 개수에만 14 bold 적용
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 14), range: (title as NSString).range(of: text))
        // 그 외에는 크기 14만 적용
        attributedString.addAttribute(.font, value: FontCase.regular14, range: (title as NSString).range(of: "의 상품"))

        // 설정먹인 문자열 반환
        return attributedString
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
