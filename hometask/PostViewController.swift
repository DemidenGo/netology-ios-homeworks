//
//  PostViewController.swift
//  hometask_1.3
//
//  Created by Юрий Демиденко on 09.04.2022.
//

import UIKit

class PostViewController: UIViewController {

    var post: Post?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        self.title = post?.title
        makeBarItem()
    }

    private func makeBarItem() {
        let barButtonItem = UIBarButtonItem(title: "Инфо", style: .plain, target: self, action: #selector(tapAction))
        navigationItem.rightBarButtonItem = barButtonItem
    }

    @objc private func tapAction() {
        let infoVC = InfoViewController()
        present(infoVC, animated: true)
    }

}
