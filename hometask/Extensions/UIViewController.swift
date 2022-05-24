//
//  UIViewController.swift
//  hometask
//
//  Created by Юрий Демиденко on 04.05.2022.
//

import UIKit

//MARK: - addTapGestureToHideKeyboard

extension UIViewController {

    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing(_:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
}
