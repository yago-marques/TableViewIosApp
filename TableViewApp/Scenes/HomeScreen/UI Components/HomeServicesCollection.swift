//
//  HomeCollection.swift
//  TableViewApp
//
//  Created by Yago Marques on 13/07/23.
//

import UIKit

struct HomeServiceCollectionViewModel: TableViewCellViewModel {
    let options: [ServiceOption]

    struct ServiceOption {
        let name: String
    }
}

final class HomeServicesCollection: UITableViewCell, TableViewCellBuilder {

    private var viewModel: HomeServiceCollectionViewModel? = nil
    private var controller: HomeControllerDelegate? = nil

    private let collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        return layout
    }()

    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: self.collectionLayout)
        collection.register(HomeCollectionOptionCell.self, forCellWithReuseIdentifier: HomeCollectionOptionCell.identifier)
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false

        return collection
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: TableViewCellViewModel, and controller: TableViewCellBuilderController) {
        guard let homeCollectionViewModel = viewModel as? HomeServiceCollectionViewModel else { return }
        guard let homeController = controller as? HomeControllerDelegate else { return }

        self.viewModel = homeCollectionViewModel
        self.controller = homeController
    }

}

extension HomeServicesCollection: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         viewModel?.options.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collection.dequeueReusableCell(withReuseIdentifier: HomeCollectionOptionCell.identifier, for: indexPath) as? HomeCollectionOptionCell else { return UICollectionViewCell() }

        guard let option = viewModel?.options[indexPath.row] else { return UICollectionViewCell() }
        cell.configure(with: option)

        return cell
    }
}

extension HomeServicesCollection: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collection.frame.width
        return CGSize(width: width * 0.485, height: width * 0.25)
    }
}

extension HomeServicesCollection: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let service = viewModel?.options[indexPath.row]

        if service?.name.lowercased() == "pokemons" {
            controller?.navigateToPokemonListView()
        }
    }
}

extension HomeServicesCollection: ViewCoding {
    func setupView() {
        self.selectionStyle = .none
        self.backgroundColor = .systemGray6
    }

    func setupHierarchy() {
        contentView.addSubview(self.collection)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 350),

            collection.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            collection.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            collection.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            collection.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
