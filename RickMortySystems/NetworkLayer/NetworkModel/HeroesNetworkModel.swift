//
//  HeroesNetworkModel.swift
//  RickMortySystems
//
//  Created by Артём Тюрморезов on 17.08.2023.
//

import Foundation

struct NetworkHeroesDataModel: Decodable {
    let info: Info?
    let results: [CharacterResult]?
}

struct Info: Decodable {
    let count: Int?
    let pages: Int?
    let next: String?
    let prev: String?
}

struct CharacterResult: Decodable {
    let id: Int?
    let name: String?
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let origin: Location?
    let location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}


struct Location: Decodable, Equatable {
    let name: String?
    let url: String?
}

struct OriginModel: Decodable {
    let name: String
    let type: String
}

struct EpisodeModel: Decodable {
    let name: String
    let airDate: String
    let episode: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case airDate = "air_date"
        case episode
    }
}
