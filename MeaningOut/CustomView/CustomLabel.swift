//
//  CustomLabel.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/15/24.
//

import UIKit

class CustomLabel: UILabel {
    init(title: String = "", color: UIColor = ColorCase.black, fontCase: UIFont) {
        super.init(frame: .zero)
        configureLabel(title, color, fontCase)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLabel(_ title: String, _ color: UIColor, _ fontCase: UIFont) {
        text = title
        textColor = color
        font = fontCase
    }
}
