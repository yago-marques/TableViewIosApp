//
//  HomeCoordinator.swift
//  TableViewApp
//
//  Created by Yago Marques on 27/07/23.
//

import UIKit

protocol HomeCoordinatorDelegate {
    var navigator: UINavigationController? { get set }
    func navigateToPokemonListView()
}

final class HomeCoordinator: HomeCoordinatorDelegate {
    var navigator: UINavigationController?

    init(navigator: UINavigationController? = nil) {
        self.navigator = navigator
    }

    func navigateToPokemonListView() {
        navigator?.pushViewController(PokemonListFactory.make(), animated: true)
    }
}
