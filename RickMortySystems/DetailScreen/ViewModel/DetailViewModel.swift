//
//  DetailViewModel.swift
//  RickMortySystems
//
//  Created by Артём Тюрморезов on 17.08.2023.
//

import Foundation

final class DetailViewModel: DetailViewModelProtocol, ObservableObject {
    
    // MARK: Public properties
    
    @Published var model: HeroModelDataObject
    @Published var episodes = [EpisodeModel]()
    @Published var origin = OriginModel(name: "This hero haven't info", type: "Unknown")
    @Published var isLoaded = false
    let networkManager: HeroesNetworkServiceProtocol
    
    // MARK: Private methods
    
    private func getEpisodes() {
        networkManager.getEpisodeInfo(model.episodes) { [weak self] result in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                self?.episodes = data
            case .failure(_):
                break
            }
        }
    }
    
    private func getOrigin() {
        networkManager.getOriginInfo(model.origin) { [weak self] result in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self?.origin = data
                }
            case .failure(_):
                break
            }
        }
    }
    
    // MARK: - Public methods
    
    func configureData() {
        self.getOrigin()
        self.getEpisodes()
        DispatchQueue.main.async {
            self.isLoaded = true
        }
    }
    
    func episodeNumber(from string: String) -> String {
        if let range = string.range(of: #"E(\d+)"#, options: .regularExpression) {
            let episodeNumber = String(string[range].dropFirst())
            return String(Int(episodeNumber) ?? 0)
        } else {
            return ""
        }
    }
    
    func seasonNumber(from string: String) -> String {
        if let range = string.range(of: #"S(\d+)"#, options: .regularExpression) {
            let seasonNumber = String(string[range].dropFirst())
            return String(Int(seasonNumber) ?? 0)
        } else {
            return ""
        }
    }
    
    // MARK: - Init
    
    init(model: HeroModelDataObject, networkManager: HeroesNetworkServiceProtocol ) {
        self.model = model
        self.networkManager = networkManager
    }
}
