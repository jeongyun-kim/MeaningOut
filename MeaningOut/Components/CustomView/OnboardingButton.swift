//
//  OnboardingButton.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/13/24.
//

import UIKit
import SnapKit

class OnboardingButton: UIButton {
    init(title: String) {
        super.init(frame: .zero)
        configureButton(title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureButton(_ title: String) {
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        setTitleColor(Resource.ColorCase.white, for: .normal)
        backgroundColor = Resource.ColorCase.primaryColor
        layer.cornerRadius = 23
        snp.makeConstraints { make in
            make.height.equalTo(46)
        }
    }
}
