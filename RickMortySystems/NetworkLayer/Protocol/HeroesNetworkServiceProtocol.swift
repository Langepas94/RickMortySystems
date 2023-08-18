//
//  HeroesNetworkServiceProtocol.swift
//  RickMortySystems
//
//  Created by Артём Тюрморезов on 17.08.2023.
//

import Foundation

protocol HeroesNetworkServiceProtocol {
    func getAllCharacters(page: Int, completion: @escaping(Result<NetworkHeroesDataModel?, NetworkErrors>) -> Void)
    func getEpisodeInfo(_ episodes: [String], completion: @escaping(Result<[EpisodeModel]?, NetworkErrors>) -> Void)
    func getOriginInfo(_ location: Location, completion: @escaping(Result<OriginModel?, NetworkErrors>) -> Void)
}
