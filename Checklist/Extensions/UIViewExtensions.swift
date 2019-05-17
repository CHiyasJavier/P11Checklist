//
//  UIViewExtensions.swift
//  Earnest
//
//  Created by Novare Account on 20/02/2019.
//  Copyright © 2019 Bon Ryan Santiano. All rights reserved.
//

import UIKit

extension UIView {

    func subview(forAutoLayout subview: UIView) {
        self.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
    }

    func subviews(forAutoLayout subviews: UIView...) {
        self.subviews(forAutoLayout: subviews)
    }

    func subviews(forAutoLayout subviews: [UIView]) {
        subviews.forEach(self.subview)
    }

    func setRadius(radius: CGFloat? = nil) {
        self.layer.cornerRadius = radius ?? self.frame.width / 2
        self.layer.masksToBounds = true
    }
}
