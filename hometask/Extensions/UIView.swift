//
//  UIView+Extension.swift
//  hometask
//
//  Created by Юрий Демиденко on 26.04.2022.
//

import UIKit

extension UIView {
    
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIView {
    
    func shake(duration: TimeInterval = 0.5, translation: CGFloat = 10) {
        let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.3) {
            self.transform = CGAffineTransform(translationX: translation, y: 0)
        }

        propertyAnimator.addAnimations({
            self.transform = CGAffineTransform(translationX: 0, y: 0)
        }, delayFactor: 0.2)

        propertyAnimator.startAnimation()
    }
}
