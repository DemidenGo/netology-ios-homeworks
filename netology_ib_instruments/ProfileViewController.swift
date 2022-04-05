//
//  ProfileViewController.swift
//  netology_ib_instruments
//
//  Created by Юрий Демиденко on 05.04.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let screenWidth = UIScreen.main.bounds.width
        if let profileView = Bundle.main.loadNibNamed("ProfileView", owner: nil, options: nil)?.first as? ProfileView {
            profileView.frame = CGRect(x: 16, y: 40, width: screenWidth - 32, height: 350)
            view.addSubview(profileView)
        }

    }
}
