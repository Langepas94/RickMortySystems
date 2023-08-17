//
//  FlowController.swift
//  RickMortySystems
//
//  Created by Артём Тюрморезов on 17.08.2023.
//

import Foundation
import UIKit

final class FlowController: UINavigationController {
    
    let viewModel = MainScreenViewModel()
    // MARK: - Private methods
    
    private func goToMainScreen() {
        let mainView = MainScreenView()
        mainView.viewModel  = viewModel
        
        viewModel.flowController = self
        self.navigationBar.prefersLargeTitles = true
        self.pushViewController(mainView, animated: false)
    }
    
    func goToDetailScreen(_ model: HeroModelDataObject) {
        
        let detailViewModel = DetailViewModel(model: model)
        let detailView = SwiftUIViewController(viewModel: detailViewModel)
        self.pushViewController(detailView, animated: true)
        
        let backButton = UIBarButtonItem(title: self.title, style: .plain, target: nil, action: nil)
        backButton.tintColor = .white
        self.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    public init() {
            super.init(nibName: nil, bundle: nil)
        goToMainScreen()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
