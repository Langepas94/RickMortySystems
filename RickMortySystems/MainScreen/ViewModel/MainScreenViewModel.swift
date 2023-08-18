//
//  MainScreenViewModel.swift
//  RickMortySystems
//
//  Created by Артём Тюрморезов on 17.08.2023.
//

import Foundation
import Combine

class MainScreenViewModel: MainScreenViewModelProtocol {
    
    // MARK: - Public properties
    
    enum State: Equatable {
        case idle
        case loading
        case loaded
        case error
    }
    
    enum Event {
        case onAppear
        case onPageScroll
        case onDefaultState
        case onDetailScreen(Int)
    }
    
    var passData: ((HeroModelDataObject) -> Void)?
    var service = NetworkService()
    @Published private(set) var state: State = .idle
    weak var flowController: FlowController?
    
    // MARK: - Private properties
    
    private var maximumPage: Int?
    private var pagesIsCancel: Bool = false
    private var currentPage: Int = 1
    private var model: [HeroModelDataObject]? = [HeroModelDataObject]()
    
    func send(event: Event) {
        switch event {
            
        case .onAppear:
            fetchData()
        case .onPageScroll:
            nextPage()
        case .onDefaultState:
            
            currentPage = 1
            fetchData()
            self.state = .loaded
            
            case .onDetailScreen(let index):
            goToDetail(index)
        }
    }
    
    func getModel() -> [HeroModelDataObject] {

        self.model ?? [HeroModelDataObject]()
        
    }
    
    // MARK: - Private methods
    
    private func fetchData() {
        self.service.getAllCharacters(page: currentPage) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                    let charData = data?.results
                    let heroModels = charData?.map{HeroModelDataObject(data: $0)}
                    self.maximumPage = data?.info?.pages
                    self.model?.append(contentsOf: heroModels ?? [])
                    self.state = .loaded

            case .failure(_):

                self.state = .error
            }
        }
    }
    
    private func goToDetail(_ index: Int) {
        guard let returnedModel = model?[index] else { return }
        flowController?.goToDetailScreen(returnedModel)
    }
    
    private func nextPage() {
        if currentPage < maximumPage ?? 0 {
            currentPage += 1
            fetchData()
            self.state = .loading
            
        } else if currentPage == maximumPage {
            pagesIsCancel = true
        }
    }
    
    
}
