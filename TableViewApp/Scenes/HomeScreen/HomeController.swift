//
//  HomeController.swift
//  TableViewApp
//
//  Created by Yago Marques on 13/07/23.
//

import Foundation

protocol HomeControllerDelegate: TableViewCellBuilderController {
    var dataSource: TableDataSource { get }
    var coordinator: HomeCoordinatorDelegate { get set }
    func populateViews()
    func navigateToPokemonListView()
}

typealias HomeControllerUseCases = FetchPokemonShapes

final class HomeController: HomeControllerDelegate {
    var view: HomeViewDelegate?
    var coordinator: HomeCoordinatorDelegate
    private let useCases: HomeControllerUseCases

    var dataSource: TableDataSource = .init(sections: []) {
        didSet {
            view?.updateTable()
        }
    }

    init(
        view: HomeViewDelegate? = nil,
        useCases: HomeControllerUseCases,
        coordinator: HomeCoordinatorDelegate
    ) {
        self.view = view
        self.useCases = useCases
        self.coordinator = coordinator
    }

    func populateViews() {
        view?.showLoadingIndicator()
        makeDataSource { result in
            switch result {
            case .success(let dataSource):
                self.dataSource = dataSource
                self.view?.hideLoadingIndicator()
            case .failure(let failure):
                print(failure)
            }
        }
    }

    func navigateToPokemonListView() {
        coordinator.navigateToPokemonListView()
    }

    private func makeDataSource(completion: @escaping (Result<TableDataSource, Error>) -> Void) {
        makeShapeTableViewSectionDataSource { [weak self] result in
            guard let self else { return }

            switch result {
            case .success(let PokemonShapesSection):
                completion(.success(self.makeDataSourceWithRemoteSection(PokemonShapesSection)))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }

    private func makeDataSourceWithRemoteSection(_ remoteSection: Section) -> TableDataSource {
        .init(
            sections: [
                makeBannerDataSource(),
                makeServicesSectionDataSource(),
                remoteSection
            ]
        )
    }

    private func makeBannerDataSource() -> Section {
        .init(
            title: nil,
            components: [
                .init(
                    viewModel: HomeBannerViewModel(imageUrl: "https://img.elo7.com.br/product/zoom/1BC78E2/banner-painel-festa-decorativo-pokemon-pikachu.jpg"),
                    builder: HomeBanner.self
                )
            ]
        )
    }

    private func makeServicesSectionDataSource() -> Section {
        .init(
            title: "Services",
            components: [
                .init(
                    viewModel: HomeServiceCollectionViewModel(options: [
                        .init(name: "Pokemons"),
                        .init(name: "Abilities"),
                        .init(name: "Natures"),
                        .init(name: "Types"),
                        .init(name: "Moves")
                    ]),
                    builder: HomeServicesCollection.self
                )
            ]
        )
    }

    private func makeShapeTableViewSectionDataSource(completion: @escaping (Result<Section, Error>) -> Void) {
        fetchPokemonShapesModels { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let shapes):
                completion(.success(self.makeTableShapeSection(with: shapes)))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }

    }

    private func makeTableShapeSection(with shapes: [PokemonsShapeTableViewModel.PokemonShape]) -> Section {
        .init(
            title: "Pokemon Shapes",
            components: [
                .init(
                    viewModel: PokemonsShapeTableViewModel(
                        shapes: shapes
                    ),
                    builder: PokemonsShapeTable.self
                )
            ]
        )
    }

    private func fetchPokemonShapesModels(
        completion: @escaping (Result<[PokemonsShapeTableViewModel.PokemonShape], Error>) -> Void
    ) {
        useCases.fetchPokemonShapes { result in
            switch result {
            case .success(let success):
                let viewModels = success.map { PokemonShapeMapper.toViewModel(from: $0) }

                completion(.success(viewModels))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
