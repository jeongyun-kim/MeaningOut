//
//  NicknameTextField.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/13/24.
//

import UIKit

class NicknameTextField: UITextField {
    init(placeholderType: Placeholder) {
        super.init(frame: .zero)
        placeholder = placeholderType.rawValue
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        leftViewMode = .always
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
