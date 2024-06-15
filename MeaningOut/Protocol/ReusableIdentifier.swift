//
//  ReusableIdentifier.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/14/24.
//

import UIKit

protocol ReusableIdentifier {
    static var identifier: String { get }
}

extension UICollectionViewCell: ReusableIdentifier {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableIdentifier {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewHeaderFooterView: ReusableIdentifier {
    static var identifier: String {
        return String(describing: self)
    }
}

