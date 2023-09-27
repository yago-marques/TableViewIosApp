//
//  PokemonsList.swift
//  TableViewApp
//
//  Created by Yago Marques on 17/07/23.
//

import UIKit

protocol PokemonListViewDelegate: AnyObject {
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func updateTable()
}

final class PokemonListView: UITableViewController {

    private let controller: PokemonListControllerDelegate

    private let loadingIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()

        return spinner
    }()

    init(controller: PokemonListControllerDelegate) {
        self.controller = controller
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorStyle = .none
        view.backgroundColor = .systemGray6
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        controller.showPokemonList()
    }

}

extension PokemonListView {
    override func numberOfSections(in tableView: UITableView) -> Int {
        controller.dataSource.sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        for (index, sectionSource) in controller.dataSource.sections.enumerated() where section == index {
            return sectionSource.components.count
        }

        return 0
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        for (index, sectionSource) in controller.dataSource.sections.enumerated() where section == index {
            return sectionSource.title
        }

        return "invalid"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = controller.dataSource.sections[indexPath.section]
        let cellComponent = section.components[indexPath.row]
        let cell = cellComponent.builder.init()
        cell.configure(with: cellComponent.viewModel, and: self.controller)

        return cell
    }
}

extension PokemonListView: PokemonListViewDelegate {
    func showLoadingIndicator() {
        view.addSubview(loadingIndicator)

        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor, constant: -100)
        ])
    }

    func hideLoadingIndicator() {
        DispatchQueue.main.async {
            self.loadingIndicator.removeFromSuperview()
        }
    }

    func updateTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
