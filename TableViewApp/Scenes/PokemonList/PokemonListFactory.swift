//
//  PokemonListFactory.swift
//  TableViewApp
//
//  Created by Yago Marques on 17/07/23.
//

import UIKit

enum PokemonListFactory {
    static func make() -> UIViewController {
        let controller = PokemonListController()
        let view = PokemonListView(controller: controller)
        controller.view = PokemonListViewProxy(view: view)

        return view
    }
}
