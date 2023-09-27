//
//  PokemonListViewProxy.swift
//  TableViewApp
//
//  Created by Yago Marques on 17/07/23.
//

import Foundation

final class PokemonListViewProxy: PokemonListViewDelegate {

    weak var view: PokemonListViewDelegate?

    init(view: PokemonListViewDelegate) {
        self.view = view
    }

    func showLoadingIndicator() {
        view?.showLoadingIndicator()
    }

    func hideLoadingIndicator() {
        view?.hideLoadingIndicator()
    }

    func updateTable() {
        view?.updateTable()
    }

}
