//
//  FlowController.swift
//  RickMortySystems
//
//  Created by Артём Тюрморезов on 17.08.2023.
//

import Foundation
import UIKit

final class FlowController: UINavigationController {
    
    // MARK: - Private methods
    
    private func mainScreen() {
        let networkManager = NetworkService()
        let viewModel = MainScreenViewModel(networkService: networkManager)
        viewModel.flowController = self
        let mainView = MainScreenView(viewModel: viewModel)
        self.pushViewController(mainView, animated: false)
    }
    
    // MARK: Public methods
    
    func goToDetailScreen(_ model: HeroModelDataObject) {
        backButtonAppearance()
        let networkManager = NetworkService()
        let detailViewModel = DetailViewModel(model: model, networkManager: networkManager)
        let detailView = SwiftUIViewController(viewModel: detailViewModel)
        self.pushViewController(detailView, animated: true)
    }
    
    // MARK: - Init's
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        self.navigationBar.prefersLargeTitles = false
        self.navigationBar.standardAppearance.backgroundColor = .bgColor
        mainScreen()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: NavigationBar settings

extension FlowController {
    func backButtonAppearance() {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backButton.tintColor = .white
        self.navigationBar.topItem?.backBarButtonItem = backButton
    }
}
