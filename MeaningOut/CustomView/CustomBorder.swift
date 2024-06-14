//
//  CustomBorder.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/13/24.
//

import UIKit
import SnapKit

class CustomBorder: UIView {
    init(){
        super.init(frame: .zero)
        configureBorder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureBorder() {
        backgroundColor = ColorCase.borderColor
        snp.makeConstraints { make in
            make.height.equalTo(1)
        }
    }
}
