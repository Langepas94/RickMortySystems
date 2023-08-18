//
//  DetailViewModelProtocol.swift
//  RickMortySystems
//
//  Created by Артём Тюрморезов on 17.08.2023.
//

import Foundation

protocol DetailViewModelProtocol {
    var model: HeroModelDataObject { get set }
    func configureData()
}
