//
//  InfoViewController.swift
//  hometask_1.3
//
//  Created by Юрий Демиденко on 09.04.2022.
//

import UIKit

final class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        self.title = "Инфо"
        makeButton()
    }

    private func makeButton() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        button.center = view.center
        button.setTitle("Показать алерт", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        view.addSubview(button)
    }

    @objc private func tapAction() {
        let alert = UIAlertController(title: "Важный алерт", message: "Вывести сообщение в консоль?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            print("Сработал AlertAction у AlertController'а")
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}
