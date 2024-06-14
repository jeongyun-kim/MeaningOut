//
//  ProfileLayerView.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/14/24.
//

import UIKit
import SnapKit

class ProfileLayerView: UIView{
    let size = 120
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: size, height: size))
        configureLayout()
    }
   
    private func configureLayout() {
        layer.borderWidth = Border.profile
        layer.borderColor = Color.primaryColor.cgColor
        layer.masksToBounds = true
        snp.makeConstraints { make in
            make.size.equalTo(size)
        }
        layer.cornerRadius = frame.width / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
