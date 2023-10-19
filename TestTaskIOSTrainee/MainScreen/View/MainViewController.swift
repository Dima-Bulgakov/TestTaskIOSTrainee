//
//  MainViewController.swift
//  TestTaskIOSTrainee
//
//  Created by Dima on 19.10.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    private let mainViewModel = MainViewModel()
    
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
        fetchDataAndReloadTableView()
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
    
    private func fetchDataAndReloadTableView() {
        mainViewModel.getPosts { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - Extensions
/// DataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MainTableViewCell.cellID,
            for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        
        let post = mainViewModel.indexPost(at: indexPath.row)
        let formattedDate = mainViewModel.formattedDateForPost(at: indexPath.row)
        
        cell.titleLabel.text = post.title
        cell.descriptionLabel.text = post.previewText
        cell.likeLabel.text = "❤️\(post.likesCount)"
        cell.dateLabel.text = formattedDate
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainViewModel.postsCount()
    }
}

/// Delegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

/// Constrains
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
