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
    private let detailNetworkManager = DetailNetworkManager()
    private var expandedCell: IndexSet = []

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
        setupSortedButton()
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
    
    private func setupSortedButton() {
        let date = UIAction(title: "Date",
                            image: UIImage(systemName: "calendar")) { [weak self] _ in
            self?.mainViewModel.sortPostsByDate()
            self?.tableView.reloadData()
        }
        
        let rate = UIAction(title: "Rate",
                            image: UIImage(systemName: "heart")) { [weak self] _ in
            self?.mainViewModel.sortPostsByRate()
            self?.tableView.reloadData()
        }
        
        let topMenu = UIMenu(title: "Sorted by", children: [date, rate])
        let barButton = UIBarButtonItem(
            image: UIImage(named: "sort"),
            menu: topMenu)
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = barButton        
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
        
        /// Set the expandButton functionality: expand and collapse description
        if expandedCell.contains(indexPath.row) {
            cell.descriptionLabel.numberOfLines = 0
            cell.expandButton.setTitle("Collapse", for: .normal)
        }
        else {
            cell.descriptionLabel.numberOfLines = 2
        }
        
        cell.expandButtonTapped = {
            if self.expandedCell.contains(indexPath.row) {
                self.expandedCell.remove(indexPath.row)
            } else {
                self.expandedCell.insert(indexPath.row)
            }
            tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
        
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
        let selectedID = "\(mainViewModel.indexPost(at: indexPath.row).postId)"
        detailViewController.selectedID = selectedID
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
