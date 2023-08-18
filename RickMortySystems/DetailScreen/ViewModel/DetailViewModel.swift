//
//  DetailViewModel.swift
//  RickMortySystems
//
//  Created by Артём Тюрморезов on 17.08.2023.
//

import Foundation

class DetailViewModel: DetailViewModelProtocol, ObservableObject {
    
    @Published var model: HeroModelDataObject
    @Published var episodes = [EpisodeModel]()
    @Published var origin = OriginModel(name: "", type: "")
    let networkManager = NetworkService()
    
    func getEpisodes() {
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
    
    func getOrigin() {
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
    
    func confogureData() {
        
            self.getOrigin()
            self.getEpisodes()
        
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
    
    init(model: HeroModelDataObject) {
        self.model = model
        
    }
}
