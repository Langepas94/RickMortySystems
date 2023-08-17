//
//  DetailViewModel.swift
//  RickMortySystems
//
//  Created by Артём Тюрморезов on 17.08.2023.
//

import Foundation

class DetailViewModel: DetailViewModelProtocol, ObservableObject {
    
    @Published var model: HeroModelDataObject
    
    
    init(model: HeroModelDataObject) {
        self.model = model
    }
}
