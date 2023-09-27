//
//  HomeViewProxy.swift
//  TableViewApp
//
//  Created by Yago Marques on 14/07/23.
//

import Foundation

final class HomeViewProxy: HomeViewDelegate {
    weak var view: HomeViewDelegate?

    init(view: HomeViewDelegate) {
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
