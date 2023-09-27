//
//  Factory.swift
//  TableViewApp
//
//  Created by Yago Marques on 13/07/23.
//

import UIKit

enum HomeFactory {
    static func make() -> UIViewController {
        let coordinator = HomeCoordinator()
        let controller = HomeController(
            useCases: RemotePokemonLoader(
                network: NetworkService(session: URLSession.shared)
            ),
            coordinator: coordinator
        )
        let view = HomeView(controller: controller)

        controller.view = HomeViewProxy(view: view)

        return view
    }
}
