//
//  RemotePokemonLoader.swift
//  TableViewApp
//
//  Created by Yago Marques on 14/07/23.
//

import Foundation

final class RemotePokemonLoader {
    private let network: NetworkServiceDelegate
    private let decoder = JSONDecoder()

    init(network: NetworkServiceDelegate) {
        self.network = network
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
}

// Pokemon Shapes Loader
extension RemotePokemonLoader: FetchPokemonShapes {
    func fetchPokemonShapes(completion: @escaping (Result<[PokemonShapeBusinessModel], Error>) -> Void) {
        network.get(path: "/pokemon-shape") { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                do {
                    let businessModels = try self.makeBusinessPokemonShapes(with: data)
                    completion(.success(businessModels))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }

    private func decodePokemonShapes(from data: Data) throws -> PokemonShapeRemoteModel {
        try decoder.decode(PokemonShapeRemoteModel.self, from: data)
    }

    private func makeBusinessPokemonShapes(with data: Data) throws -> [PokemonShapeBusinessModel] {
        let remoteModels = try decodePokemonShapes(from: data)

        return remoteModels.results.map { PokemonShapeMapper.toBusiness(from: $0) }
    }
}
