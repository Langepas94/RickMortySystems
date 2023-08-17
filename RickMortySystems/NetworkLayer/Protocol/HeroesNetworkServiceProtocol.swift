//
//  HeroesNetworkServiceProtocol.swift
//  RickMortySystems
//
//  Created by Артём Тюрморезов on 17.08.2023.
//

import Foundation

protocol HeroesNetworkServiceProtocol {
    func getAllCharacters(page: Int, completion: @escaping(Result<NetworkHeroesDataModel?, NetworkErrors>) -> Void)
    
}
