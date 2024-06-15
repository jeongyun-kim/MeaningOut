//
//  SettingTableViewCell.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/15/24.
//

import UIKit
import SnapKit

class SettingTableViewCell: UITableViewCell, SetupView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = FontCase.regular14
        label.text = "오에에에엥"
        return label
    }()
    
    lazy var border = CustomBorder(color: ColorCase.black)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupConstraints()
    }
    
    func setupHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(border)
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
    }
    
    func configureCell(_ data: SettingCellTitle) {
        titleLabel.text = data.rawValue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
