//
//  NetworkService.swift
//  TableViewApp
//
//  Created by Yago Marques on 14/07/23.
//

import Foundation

enum NetworkServiceError: Error {
    case invalidUrl
    case requestError
}

protocol NetworkServiceDelegate {
    func get(path: String, completion: @escaping (Result<Data, NetworkServiceError>) -> Void)
}

final class NetworkService: NetworkServiceDelegate {
    private let session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    func get(path: String, completion: @escaping (Result<Data, NetworkServiceError>) -> Void) {
        guard let url = makeUrl(of: path) else {
            completion(.failure(.invalidUrl))
            return
        }

        let request = URLRequest(url: url)

        let task = session.dataTask(with: request) { [weak self] data, response, error in
            guard let self else { return }

            if let _ = error {
                completion(.failure(.requestError))
                return
            }

            if let data, self.responseIsValid(response) {
                completion(.success(data))
            } else {
                completion(.failure(.requestError))
            }
        }

        task.resume()
    }

    private func makeUrl(of path: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "pokeapi.co"
        components.path = "/api/v2\(path)"

        return components.url
    }

    private func responseIsValid(_ response: URLResponse?) -> Bool {
        guard let httpResponse = response as? HTTPURLResponse else {
            return false
        }

        return (200...299) ~= httpResponse.statusCode
    }
}
