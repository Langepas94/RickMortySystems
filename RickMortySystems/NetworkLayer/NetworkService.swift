//
//  NetworkService.swift
//  RickMortySystems
//
//  Created by Артём Тюрморезов on 17.08.2023.
//

import Foundation

class NetworkService: HeroesNetworkServiceProtocol {
    
    
    static func baseURL() -> String {
        "https://rickandmortyapi.com/api/character"
    }
    
    func getAllCharacters(page: Int, completion: @escaping (Result<NetworkHeroesDataModel?, NetworkErrors>) -> Void) {
        var urlComponents = URLComponents(string: NetworkService.baseURL())
        let queryItems = [URLQueryItem(name: "page", value: "\(page)")]
        urlComponents?.queryItems = queryItems
        let completedURL = urlComponents?.url
        guard let url = completedURL else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(NetworkErrors.notNetworkAvailable))
            }
            guard let data = data else {
                completion(.failure(NetworkErrors.unknownError(error: response?.description ?? "unknown error")))
                return
            }
            do {
                let jsonData = try JSONDecoder().decode(NetworkHeroesDataModel.self, from: data)
                completion(.success(jsonData))
            } catch {
                completion(.failure(NetworkErrors.unknownError(error: error.localizedDescription)))
            }
        }
        task.resume()
    }
    
    func getEpisodeInfo(_ episodes: [String], completion: @escaping (Result<[EpisodeModel]?, NetworkErrors>) -> Void) {
        
        let dispatchGroup = DispatchGroup()
        var episodesArray: [EpisodeModel] = []
        
        for episode in episodes {
            
            if let url = URL(string: episode) {
                dispatchGroup.enter()
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    defer {
                        dispatchGroup.leave()
                    }
                    guard let data = data else { completion(.failure(NetworkErrors.unknownError(error: response?.description ?? "unknown error")))
                        return }
                    
                    do {
                        let jsonData = try JSONDecoder().decode(EpisodeModel.self, from: data)
                        episodesArray.append(jsonData)
                        
                    } catch {
                        completion(.failure(NetworkErrors.unknownError(error: error.localizedDescription)))
                    }
                    
                }
                
                task.resume()
            }
            
        }
        dispatchGroup.notify(queue: .main) {
            completion(.success(episodesArray))
        }
    }
    
    func getOriginInfo(_ location: Location, completion: @escaping (Result<OriginModel?, NetworkErrors>) -> Void) {
            guard let url = URL(string: location.url ?? "") else { return }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
              
                guard let data = data else { completion(.failure(NetworkErrors.unknownError(error: response?.description ?? "unknown error")))
                    return }
                
                do {
                    let jsonData = try JSONDecoder().decode(OriginModel.self, from: data)
                    completion(.success(jsonData))
                    
                } catch {
                    completion(.failure(NetworkErrors.unknownError(error: error.localizedDescription)))
                }
                
            }
            
            task.resume()
        
    }
}
