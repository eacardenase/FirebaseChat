//
//  UIViewController+GradientLayer.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/9/25.
//

import UIKit

extension UIViewController {

    func configureGradientLayer() {
        let gradient = CAGradientLayer()

        gradient.frame = view.frame
        gradient.colors = [
            UIColor.systemPurple.cgColor, UIColor.systemTeal.cgColor,
        ]

        view.layer.addSublayer(gradient)
    }

}
