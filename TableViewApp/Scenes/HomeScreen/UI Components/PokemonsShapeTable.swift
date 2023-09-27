//
//  ShapeTable.swift
//  TableViewApp
//
//  Created by Yago Marques on 13/07/23.
//

import UIKit

struct PokemonsShapeTableViewModel: TableViewCellViewModel {
    let shapes: [PokemonShape]

    struct PokemonShape {
        let shape: String
        let url: String
    }
}

final class PokemonsShapeTable: UITableViewCell, TableViewCellBuilder {
    private var shapes: [PokemonsShapeTableViewModel.PokemonShape] = [] {
        didSet {
            shapeTable.reloadData()
        }
    }

    private lazy var shapeTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.separatorStyle = .none
        table.register(PokemonShapeCell.self, forCellReuseIdentifier: PokemonShapeCell.identifier)
        table.backgroundColor = .systemGray6

        return table
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        buildLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    func configure(with viewModel: TableViewCellViewModel, and controller: TableViewCellBuilderController) {
        guard let pokemonShapeTableViewModel = viewModel as? PokemonsShapeTableViewModel else { return }

        shapes = pokemonShapeTableViewModel.shapes
    }
}

extension PokemonsShapeTable: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shapes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = shapeTable.dequeueReusableCell(withIdentifier: PokemonShapeCell.identifier, for: indexPath) as? PokemonShapeCell else { return UITableViewCell() }
        cell.configure(shapeName: shapes[indexPath.row].shape)
        
        return cell
    }
}

extension PokemonsShapeTable: ViewCoding {
    func setupView() {
        self.backgroundColor = .systemGray6
    }

    func setupHierarchy() {
        contentView.addSubview(shapeTable)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 350),

            shapeTable.topAnchor.constraint(equalTo: contentView.topAnchor),
            shapeTable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shapeTable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            shapeTable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
