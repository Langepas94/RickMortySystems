//
//  MainScreenCollectionCell.swift
//  RickMortySystems
//
//  Created by Артём Тюрморезов on 17.08.2023.
//

import Foundation
import UIKit

class MainScreenCollectionCell: UICollectionViewCell {
    static let reuseID = "MainScreenCollectionCell"
    
    private let heroImage: UIImageView = {
          let image = UIImageView()
          
          image.contentMode = .center
          
          return image
      }()
    
    private let heroNameLabel: UILabel = {
          let label = UILabel()
          label.textColor = .black
        label.font = .systemFont(ofSize: 21)
          label.textAlignment = .left
          return label
      }()
}
