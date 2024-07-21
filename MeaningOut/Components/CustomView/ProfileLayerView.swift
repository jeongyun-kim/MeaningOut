//
//  ProfileLayerView.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/14/24.
//

import UIKit
import SnapKit

class ProfileLayerView: UIView{

    init(_ profileLayerSize: Resource.ProfileLayerSizeCase) {
        super.init(frame: .zero)
        configureLayout(profileLayerSize)
    }
   
    private func configureLayout(_ profileLayerSize: Resource.ProfileLayerSizeCase) {
        layer.borderWidth = Resource.BorderCase.profile
        layer.borderColor = Resource.ColorCase.highlightColor.cgColor
        layer.masksToBounds = true
        
        let size = profileLayerSize.rawValue
        if size != 0 {
            snp.makeConstraints { make in
                make.size.equalTo(size)
            }
            layer.cornerRadius = CGFloat(size / 2)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
