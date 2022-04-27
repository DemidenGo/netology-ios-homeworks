//
//  UIImageView+Extension.swift
//  hometask
//
//  Created by Юрий Демиденко on 26.04.2022.
//

import UIKit

extension UIImageView {

    func makeRounded() {
        self.layoutIfNeeded()
        self.contentMode = .scaleAspectFit
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.masksToBounds = true
    }
}
