//
//  UIImage.swift
//  hometask
//
//  Created by Юрий Демиденко on 26.04.2022.
//

import UIKit

extension UIImage {
    
    func withAlpha(_ alpha: CGFloat) -> UIImage {
        return UIGraphicsImageRenderer(size: size, format: imageRendererFormat).image { (_) in
            draw(in: CGRect(origin: .zero, size: size), blendMode: .normal, alpha: alpha)
        }
    }
}
