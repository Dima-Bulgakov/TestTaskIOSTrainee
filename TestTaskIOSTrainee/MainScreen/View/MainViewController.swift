//
//  MainViewController.swift
//  TestTaskIOSTrainee
//
//  Created by Dima on 19.10.2023.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        let mainNM = MainNetworkManager()
        mainNM.fetchData { post in
            if let post = post {
                print(post)
            }
        }
    }
}
