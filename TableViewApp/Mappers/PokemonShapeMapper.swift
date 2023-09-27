//
//  PokemonShapeMapper.swift
//  TableViewApp
//
//  Created by Yago Marques on 14/07/23.
//

import Foundation

struct PokemonShapeMapper {
    static func toBusiness(from remote: PokemonShapeRemoteModel.RemotePokemonShape) -> PokemonShapeBusinessModel {
        .init(shape: remote.name, url: remote.url)
    }

    static func toViewModel(from business: PokemonShapeBusinessModel) -> PokemonsShapeTableViewModel.PokemonShape {
        .init(shape: business.shape, url: business.url)
    }
}
