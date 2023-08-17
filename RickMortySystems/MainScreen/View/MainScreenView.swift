//
//  ViewController.swift
//  RickMortySystems
//
//  Created by Артём Тюрморезов on 17.08.2023.
//

import UIKit

final class MainScreenView: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var mainCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero,
                                           collectionViewLayout: createCompositionalLayout())
         collection.dataSource = self
         collection.delegate = self
         collection.translatesAutoresizingMaskIntoConstraints = false
//         collection.register(WeatherCellOnMainView.self,
//                             forCellWithReuseIdentifier: WeatherCellOnMainView.cellId)
//         collection.register(GeoWeatherCellOnMainView.self,
//                             forCellWithReuseIdentifier: GeoWeatherCellOnMainView.cellId)
         collection.showsVerticalScrollIndicator = false
         return collection
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - createCompositionalLayout()
      private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
          
          return UICollectionViewCompositionalLayout(section: mainLayoutSection())
      }
    
    private func mainLayoutSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalWidth(0.5))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.5))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
}

extension MainScreenView {
    
    func setupUI() {
        view.backgroundColor = .bgColor
    }
}

extension MainScreenView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //
    }
    
    
}
