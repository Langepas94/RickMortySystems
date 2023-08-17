//
//  MainScreenViewModelProtocol.swift
//  RickMortySystems
//
//  Created by Артём Тюрморезов on 17.08.2023.
//

import Foundation

protocol MainScreenViewModelProtocol {
    var passData: ((HeroModelDataObject) -> Void)? { get set }
}
