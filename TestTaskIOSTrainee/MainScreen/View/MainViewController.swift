//
//  MainViewController.swift
//  TestTaskIOSTrainee
//
//  Created by Dima on 19.10.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Properties
    private let mainViewModel = MainViewModel()
    private var expandedCell: IndexSet = []

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.idCell)
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
    private func setViews() {
        view.addSubview(tableView)
        setSortButton()
    }
    
    private func setAppearance() {
        view.backgroundColor = .white
        navigationItem.title = Helper.Name.title
    }
    
    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchDataAndReloadTableView() {
        mainViewModel.getPosts { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    /// Create sort button with UIMenu
    private func setSortButton() {
        let date = UIAction(title: Helper.Name.date, image: Helper.Image.calendar) { [weak self] _ in
            self?.mainViewModel.sortPostsByDate()
            self?.tableView.reloadData()
        }
        
        let rate = UIAction(title: Helper.Name.rate, image: Helper.Image.heart) { [weak self] _ in
            self?.mainViewModel.sortPostsByRate()
            self?.tableView.reloadData()
        }
        
        let topMenu = UIMenu(title: Helper.Name.sortedBy, children: [date, rate])
        let barButton = UIBarButtonItem( image: Helper.Image.sort, menu: topMenu)
        
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = barButton        
    }
}

// MARK: - Extensions
/// DataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MainTableViewCell.idCell,
            for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        
        /// Set cell apearance
        cell.selectionStyle = .none
        
        /// Access to data
        let post = mainViewModel.indexPost(at: indexPath.row)
        
        /// Formatted data date
        let formattedDate = mainViewModel.formattedDateForPost(at: indexPath.row)
        
        /// Hide ExpandButton
        hideExpandButton(cell, forPost: post)
        
        /// Expand and collapse text
        expandAndCollapseText(cell, indexPath: indexPath, tableView: tableView)
        
        /// Set data to UI
        cell.titleLabel.text = post.title
        cell.descriptionLabel.text = post.previewText
        cell.likeLabel.text = "❤️\(post.likesCount)"
        cell.dateLabel.text = formattedDate
        
        return cell
    }
    
    /// Number of cells in tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainViewModel.postsCount()
    }
}

/// Delegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        let selectedId = "\(mainViewModel.indexPost(at: indexPath.row).postId)"
        /// Pass the cell id to change the link in NetworkManager
        detailViewController.selectedId = selectedId
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

/// Hide button and expand button methods
extension MainViewController {
    /// Hide ExpandButton
    func hideExpandButton(_ cell: MainTableViewCell, forPost post: PostModel) {
        let descriptionText = post.previewText
        cell.descriptionLabel.text = descriptionText
        let characterCount = descriptionText.count
        if characterCount < Helper.Constant.characters {
            cell.expandButton.isHidden = true
            cell.expandButton.isEnabled = false
            NSLayoutConstraint.deactivate(cell.enabledButtonConstraints)
            NSLayoutConstraint.activate(cell.disabledButtonConstraints)
        } else {
            cell.expandButton.isHidden = false
            cell.expandButton.isEnabled = true
            NSLayoutConstraint.deactivate(cell.disabledButtonConstraints)
            NSLayoutConstraint.activate(cell.enabledButtonConstraints)
        }
    }
    
    /// Expand and collapse text
    func expandAndCollapseText(_ cell: MainTableViewCell, indexPath: IndexPath, tableView: UITableView) {
        if expandedCell.contains(indexPath.row) {
            cell.descriptionLabel.numberOfLines = 0
            cell.expandButton.setTitle(Helper.Name.collapse, for: .normal)
        } else {
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
