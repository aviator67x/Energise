//
//  UIView+layout.swift
//  REI
//
//  Created by User on 18.01.2023.
//

import SnapKit
import UIKit

extension UIView {
    func layout(using closure: (ConstraintMaker) -> Void) {
        translatesAutoresizingMaskIntoConstraints = false
        snp.makeConstraints(closure)
    }

    func addSubview(_ view: UIView, using closure: (ConstraintMaker) -> Void) {
        addSubview(view)
        view.layout(using: closure)
    }
}
