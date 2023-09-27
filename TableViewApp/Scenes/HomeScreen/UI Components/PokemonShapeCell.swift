//
//  PokemonShapeCell.swift
//  TableViewApp
//
//  Created by Yago Marques on 14/07/23.
//

import UIKit

final class PokemonShapeCell: UITableViewCell {
    static let identifier = "PokemonShapeCell"

    private let shapeName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0

        return label
    }()

    private let chevronIcon: UIImageView = {
        let icon = UIImageView(image: .init(systemName: "chevron.forward"))
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.tintColor = .systemGray3

        return icon
    }()

    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalCentering

        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        buildLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    func configure(shapeName: String) {
        self.shapeName.text = shapeName
    }
}

extension PokemonShapeCell: ViewCoding {
    func setupView() {
        self.selectionStyle = .none
        self.backgroundColor = .systemBackground
    }

    func setupHierarchy() {
        contentView.addSubview(stack)
        stack.addArrangedSubview(shapeName)
        stack.addArrangedSubview(chevronIcon)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
