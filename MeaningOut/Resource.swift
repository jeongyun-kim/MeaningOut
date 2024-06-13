//
//  Resource.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/13/24.
//

import UIKit

enum Color {
    static let primaryColor = UIColor(hue: 0.0639, saturation: 0.7, brightness: 0.93, alpha: 1.0)
    static let black = UIColor.black
    // 회색은 진한순
    static let gray1 = UIColor(hue: 0, saturation: 0, brightness: 0.29, alpha: 1.0)
    static let gray2 = UIColor(hue: 0, saturation: 0, brightness: 0.5, alpha: 1.0)
    static let gray3 = UIColor(hue: 0, saturation: 0, brightness: 0.8, alpha: 1.0)
    static let white = UIColor.white
}

enum Images {
    static let search = UIImage(named: "magnifyingglass")
    static let setting = UIImage(named: "person")
    static let next = UIImage(named: "chevron.right")
    static let clock = UIImage(named: "clock")
    static let close = UIImage(named: "xmark")
    static let profileCamera = UIImage(named: "camera.fill")
}

enum Border {
    static let selected = 3
    static let unselected = 1
}
