//
//  PaddingLabel.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/14/24.
//

import UIKit

class PaddingLabel: UILabel {
    let inset: CGFloat = 8
    
    // 패딩이 적용된 뷰에 텍스트 넣어주기
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    // label의 본래크기도 조정해주기
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + inset*2, height: size.height + inset*2)
    }
    
    // bounds값이 변할때마다 적용
    override var bounds: CGRect {
        didSet {
            preferredMaxLayoutWidth = bounds.width - inset*2
        }
    }
}
