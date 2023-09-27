//
//  PokemonShapeRemoteModel.swift
//  TableViewApp
//
//  Created by Yago Marques on 14/07/23.
//

import Foundation

struct PokemonShapeRemoteModel: Codable {
    let results: [RemotePokemonShape]

    struct RemotePokemonShape: Codable {
        let name: String
        let url: String
    }
}
