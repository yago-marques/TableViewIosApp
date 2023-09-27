//
//  PokemonListController.swift
//  TableViewApp
//
//  Created by Yago Marques on 17/07/23.
//

import Foundation

protocol PokemonListControllerDelegate: TableViewCellBuilderController {
    var dataSource: TableDataSource { get }
    func showPokemonList()
}

final class PokemonListController: PokemonListControllerDelegate {
    var view: PokemonListViewDelegate?
    var dataSource: TableDataSource = .init(sections: [])

    init(view: PokemonListViewDelegate? = nil) {
        self.view = view
    }

    func showPokemonList() {
        view?.showLoadingIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.view?.hideLoadingIndicator()
        }
    }
}
