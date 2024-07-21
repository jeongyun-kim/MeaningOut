//
//  ResourceCase.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/27/24.
//

import UIKit


extension Resource {
    enum BorderCase {
        static let profile: CGFloat = 5
        static let selected: CGFloat = 3
        static let deselected: CGFloat = 1
    }
    
    enum ViewType: String {
        case setting = "PROFILE SETTING"
        case edit = "EDIT PROFILE"
    }
    
    enum CornerRadiusCase: Int {
        case none = 0
        case buttonOrImage = 6
        case label = 15
    }
    
    enum ProfileLayerSizeCase: Int {
        case mainProfile = 120
        case headerProfile = 80
        case none = 0
        
        var inset: Int {
            self.rawValue / 20
        }
    }
}
