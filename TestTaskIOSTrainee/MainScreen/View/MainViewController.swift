//
//  MainViewController.swift
//  TestTaskIOSTrainee
//
//  Created by Dima on 19.10.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.cellID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setAppearance()
        setViews()
        setDelegate()
        setConstraints()
    }
    
    // MARK: - Methods
    func setViews() {
        view.addSubview(tableView)
    }
    
    func setAppearance() {
        view.backgroundColor = .white
    }
    
    func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - Extensions
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MainTableViewCell.cellID,
            for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        
        cell.textLabel?.text = "TEST"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}

extension MainViewController {
    func setConstraints() {
        let sideConstant: CGFloat = 20
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sideConstant),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sideConstant),
        ])
    }
}
