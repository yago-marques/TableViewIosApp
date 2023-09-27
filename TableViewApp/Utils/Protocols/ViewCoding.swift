//
//  ViewCoding.swift
//  TableViewApp
//
//  Created by Yago Marques on 13/07/23.
//

import Foundation

protocol ViewCoding {
    func setupView()
    func setupHierarchy()
    func setupConstraints()
}

extension ViewCoding {
    func buildLayout() {
        setupView()
        setupHierarchy()
        setupConstraints()
    }
}
