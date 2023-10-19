//
//  DetailViewController.swift
//  TestTaskIOSTrainee
//
//  Created by Dima on 19.10.2023.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - Properties
    let detailNetwork = DetailNetwork()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "likeLabel"
        label.numberOfLines = 0
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let likeLabel: UILabel = {
        let label = UILabel()
        label.text = "likeLabel"
        label.textColor = .gray
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "dateLabel"
        label.textColor = .gray
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 18
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
        setupViews()
        setupConstraints()
        
        detailNetwork.fetchData { result in
            if let data = result {
                print(result)
            }
        }
    }
    
    //  MARK: - Methods
    private func setupViews() {
        hStack.addArrangedSubview(likeLabel)
        hStack.addArrangedSubview(dateLabel)
        
        vStack.addArrangedSubview(titleLabel)
        vStack.addArrangedSubview(descriptionLabel)
        vStack.addArrangedSubview(hStack)
        
        scrollView.addSubview(mainImageView)
        scrollView.addSubview(vStack)
        view.addSubview(scrollView)
    }
    
    private func setupAppearance() {
        navigationItem.title = "Title"
        view.backgroundColor = .systemBackground
    }
}

// MARK: - Extensions
extension DetailViewController {
    func setupConstraints() {
        let mainImageHeightConstant: CGFloat = 400
        let vStackTopConstant: CGFloat = 40
        let vStackSideConstant: CGFloat = 20
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainImageView.heightAnchor.constraint(equalToConstant: mainImageHeightConstant),
            mainImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: vStackTopConstant),
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: vStackSideConstant),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -vStackSideConstant),
            vStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            hStack.widthAnchor.constraint(equalTo: vStack.widthAnchor)
        ])
    }
}
