//
//  HomeCollectionCell.swift
//  TableViewApp
//
//  Created by Yago Marques on 13/07/23.
//

import UIKit

final class HomeCollectionOptionCell: UICollectionViewCell {
    static let identifier = "HomeCollectionOptionCell"

    private let optionName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 0

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with option: HomeServiceCollectionViewModel.ServiceOption) {
        optionName.text = option.name.capitalized
    }
}

extension HomeCollectionOptionCell: ViewCoding {
    func setupView() {
        self.backgroundColor = .systemBackground
        self.layer.cornerCurve = .circular
        self.layer.cornerRadius = 10
    }

    func setupHierarchy() {
        addSubview(optionName)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            optionName.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            optionName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            optionName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            optionName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}
