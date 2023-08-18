//
//  MainScreenViewModelProtocol.swift
//  RickMortySystems
//
//  Created by Артём Тюрморезов on 17.08.2023.
//

import Foundation

protocol MainScreenViewModelProtocol: ObservableObject {
    func getModel() -> [HeroModelDataObject]
    func send(event: Event)
    var state: State { get set }
}
