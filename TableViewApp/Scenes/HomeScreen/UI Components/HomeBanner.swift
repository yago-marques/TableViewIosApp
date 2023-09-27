//
//  HomeBanner.swift
//  TableViewApp
//
//  Created by Yago Marques on 13/07/23.
//

import UIKit

struct HomeBannerViewModel: TableViewCellViewModel {
    let imageUrl: String
}

final class HomeBanner: UITableViewCell, TableViewCellBuilder {
    let imageBanner: UIImageView = {
        let banner = UIImageView()
        banner.translatesAutoresizingMaskIntoConstraints = false
        banner.contentMode = .scaleAspectFill

        return banner
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: TableViewCellViewModel, and controller: TableViewCellBuilderController) {
        guard let homeBannerViewModel = viewModel as? HomeBannerViewModel else { return }

        imageBanner.download(from: homeBannerViewModel.imageUrl)
    }
}

extension HomeBanner: ViewCoding {
    func setupView() { }

    func setupHierarchy() {
        contentView.addSubview(imageBanner)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 200),

            imageBanner.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageBanner.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageBanner.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageBanner.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
