//
//  UILable+insets.swift
//  Energise
//
//  Created by Andrew Kasilov on 28.04.2024.
//

import UIKit

class InsetLabel: UILabel {

    let inset = UIEdgeInsets(top: -5, left: 5, bottom: -5, right: 5)

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: inset))
    }

    override var intrinsicContentSize: CGSize {
        var intrinsicContentSize = super.intrinsicContentSize
        intrinsicContentSize.width += inset.left + inset.right
        intrinsicContentSize.height += inset.top + inset.bottom
        return intrinsicContentSize
    }

}
