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
        self.navigationBar.prefersLargeTitles = false
        self.navigationBar.standardAppearance.backgroundColor = .bgColor
        
        let mainView = MainScreenView()
        mainView.viewModel  = viewModel
        
        viewModel.flowController = self
     
        self.pushViewController(mainView, animated: false)
    }
    
    func goToDetailScreen(_ model: HeroModelDataObject) {
        
        let detailViewModel = DetailViewModel(model: model)
        let detailView = SwiftUIViewController(viewModel: detailViewModel)
       
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backButton.tintColor = .white
        self.navigationBar.topItem?.backBarButtonItem = backButton
        self.pushViewController(detailView, animated: true)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        
    
    }
    
    public init() {
            super.init(nibName: nil, bundle: nil)
        goToMainScreen()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
