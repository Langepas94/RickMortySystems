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
            case .failure(let error):
                switch error {
                case .notNetworkAvailable:
                    print("check your connection")
                case .incorrectURL:
                    print("check url")
                case .unknownError(error: let error):
                    print(error)
                }
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
        if NetworkChecker.shared.isConnected {
            self.getOrigin()
            self.getEpisodes()
            
            DispatchQueue.main.async{
                self.isLoaded = true
            }
            
            // if u want check spinner - uncomment this
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
//                self.isLoaded = true
//            }
            
        } else {
            print("no data, check your internet")
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
