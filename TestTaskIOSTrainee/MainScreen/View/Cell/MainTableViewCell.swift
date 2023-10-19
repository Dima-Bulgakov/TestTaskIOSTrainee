//
//  MainTableViewCell.swift
//  TestTaskIOSTrainee
//
//  Created by Dima on 19.10.2023.
//

import UIKit

final class MainTableViewCell: UITableViewCell {

    // MARK: - Properties
    static let cellID = Helper.Name.mainTVCell
    var expandButtonTapped: (() -> (Void))!
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .title
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 18)
        label.textColor = .text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let likeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .text
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .text
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var expandButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .button
        button.setTitle(Helper.Name.expand, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(expandButtonAction), for: .touchUpInside)
        return button
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
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setViews() {
        hStack.addArrangedSubview(likeLabel)
        hStack.addArrangedSubview(dateLabel)
        
        vStack.addArrangedSubview(titleLabel)
        vStack.addArrangedSubview(descriptionLabel)
        vStack.addArrangedSubview(hStack)
        
        addSubview(vStack)
        addSubview(expandButton)
    }
    
    @objc private func expandButtonAction() {
        expandButtonTapped()
    }
    
    /// Priority ExpandButton tap before a cell
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let buttonPoint = convert(point, to: expandButton)
        if expandButton.point(inside: buttonPoint, with: event) {
            return expandButton
        }
        return super.hitTest(point, with: event)
    }
}

// MARK: - Extension
extension MainTableViewCell {
    func setupConstraints() {
        let sideVStacConstant: CGFloat = 20
        let expandButtonHeightConstant: CGFloat = 45
        let betweenVStackAndExpandButtonConstant: CGFloat = 20
        let betweenCellsConstant: CGFloat = 30

        if expandButton.isEnabled {
            NSLayoutConstraint.activate([
                vStack.topAnchor.constraint(equalTo: topAnchor),
                vStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: sideVStacConstant),
                vStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -sideVStacConstant)
            ])

            NSLayoutConstraint.activate([
                expandButton.topAnchor.constraint(equalTo: vStack.bottomAnchor, constant: betweenVStackAndExpandButtonConstant),
                expandButton.leadingAnchor.constraint(equalTo: leadingAnchor),
                expandButton.trailingAnchor.constraint(equalTo: trailingAnchor),
                expandButton.heightAnchor.constraint(equalToConstant: expandButtonHeightConstant),
                expandButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -betweenCellsConstant)
            ])
        } else {
            NSLayoutConstraint.activate([
                vStack.topAnchor.constraint(equalTo: topAnchor),
                vStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: sideVStacConstant),
                vStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -sideVStacConstant),
                vStack.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])

        }
    }
}
