//
//  CustomBorder.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/13/24.
//

import UIKit
import SnapKit

class CustomBorder: UIView {
    init(color: UIColor = Resource.ColorCase.borderColor){
        super.init(frame: .zero)
        configureBorder(color)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureBorder(_ color: UIColor) {
        backgroundColor = color
        snp.makeConstraints { make in
            make.height.equalTo(1)
        }
    }
}
