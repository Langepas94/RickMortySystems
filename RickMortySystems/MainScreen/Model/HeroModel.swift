//
//  HeroModel.swift
//  RickMortySystems
//
//  Created by Артём Тюрморезов on 17.08.2023.
//

import Foundation

struct HeroModelDataObject: Hashable {
    
    var description: String
    var setIshiddenErrorView: Bool = true
    var image: String
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var episodes: [String]
    var origin: Location
    var location: Location
    private let identifier = UUID()
    init(data: CharacterResult) {
        self.name = data.name ?? ""
        self.image = data.image ?? ""
        self.status = data.status ?? ""
        self.species = data.species ?? ""
        self.type = data.type ?? ""
        self.gender = data.gender ?? ""
        self.origin = data.origin ?? Location(name: "", url: "")
        self.location = data.location ?? Location(name: "", url: "")
        self.description = "\(species) - \(status)"
        self.episodes = data.episode ?? [""]
    }

    init(image: String, name: String, status: String, species: String, type: String, gender: String, origin: Location, location: Location, description: String, episodes: [String]) {
        self.image = image
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.description = description
        self.episodes = episodes
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

extension HeroModelDataObject : Equatable {
    static func == (lhs: HeroModelDataObject, rhs: HeroModelDataObject) -> Bool {
        lhs.description == rhs.description && lhs.name == rhs.name && lhs.image == rhs.image && lhs.status == rhs.status && lhs.species == rhs.species && lhs.type == rhs.type && lhs.gender == rhs.gender && lhs.origin == rhs.origin && lhs.location == rhs.location
    }
}
