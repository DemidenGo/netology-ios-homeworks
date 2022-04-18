//
//  ProfileHeaderView.swift
//  hometask
//
//  Created by Юрий Демиденко on 14.04.2022.
//

import UIKit

final class ProfileHeaderView: UIView {

    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 16, y: 107, width: 120, height: 120))
        imageView.backgroundColor = .systemBlue
        imageView.image = UIImage(named: "homer")
        imageView.makeRounded()
        return imageView
    }()

    private let profileLabel: UILabel = {
        let profileLabel = UILabel(frame: CGRect(x: 152, y: 118, width: 150, height: 20))
        profileLabel.text = "Homer Simpson"
        profileLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        profileLabel.textColor = .black
        return profileLabel
    }()

    private let statusLabel: UILabel = {
        let statusLabel = UILabel(frame: CGRect(x: 152, y: 189, width: 150, height: 20))
        statusLabel.text = "Woo-Hoo!"
        statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        statusLabel.textColor = .gray
        return statusLabel
    }()

    private let statusButton: UIButton = {
        let statusButton = UIButton(frame: CGRect(x: 16, y: 265, width: UIScreen.main.bounds.width - 32, height: 50))
        statusButton.backgroundColor = .systemBlue
        statusButton.setTitleColor(.white, for: .normal)
        statusButton.setTitle("Set status", for: .normal)
        statusButton.layer.cornerRadius = 4
        statusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        statusButton.layer.shadowRadius = 4
        statusButton.layer.shadowColor = UIColor.black.cgColor
        statusButton.layer.shadowOpacity = 0.7
        statusButton.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        return statusButton
    }()

    @objc private func tapAction() {
        //print(statusLabel.text ?? "Status not set")
        guard statusText != nil && statusText != "" else { return }
        statusLabel.text = statusText
    }

    private let statusTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 152, y: 215, width: UIScreen.main.bounds.width - 168, height: 40))
        textField.placeholder = "Enter your status here"
        textField.makeIndent(points: 10)
        textField.clearButtonMode = .whileEditing
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 12
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()

    private var statusText: String?

    @objc private func textFieldDidChange() {
        statusText = statusTextField.text
    }

    func addCustomSubviews() {
        addSubview(imageView)
        addSubview(profileLabel)
        addSubview(statusLabel)
        addSubview(statusButton)
        addSubview(statusTextField)
    }
}

extension UIImageView {

    func makeRounded() {
        self.contentMode = .scaleAspectFit
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.masksToBounds = true
    }
}

extension UITextField {

    func makeIndent(points: CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: points, height: self.frame.height))
        self.leftViewMode = .always
    }
}
