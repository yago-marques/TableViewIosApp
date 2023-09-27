//
//  FetchPokemonShapes.swift
//  TableViewApp
//
//  Created by Yago Marques on 14/07/23.
//

import Foundation

struct PokemonShapeBusinessModel {
    let shape: String
    let url: String
}

protocol FetchPokemonShapes {
    func fetchPokemonShapes(completion: @escaping (Result<[PokemonShapeBusinessModel], Error>) -> Void)
}
