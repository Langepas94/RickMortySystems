//
//  MainScreenCollectionCell.swift
//  RickMortySystems
//
//  Created by Артём Тюрморезов on 17.08.2023.
//

import Foundation
import UIKit
import Kingfisher

final class MainScreenCollectionCell: UICollectionViewCell {
    static let reuseID = "MainScreenCollectionCell"
    
    // MARK: - Private propeties
    
    private let heroImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .center
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let heroNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImage.layer.cornerRadius = 10
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    // MARK: - Configure method
    
    func configure(_ model: HeroModelDataObject?) {
        
        setupUI()
        heroNameLabel.text = model?.name ?? ""
        heroImage.kf.setImage(with: URL(string: model?.image ?? ""))
        
    }
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Setup appearance

extension MainScreenCollectionCell {
    
    func setupUI() {
      
        addSubview(heroImage)
        addSubview(heroNameLabel)
        
        NSLayoutConstraint.activate([
            heroImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            heroImage.heightAnchor.constraint(equalToConstant: 140),
            heroImage.widthAnchor.constraint(equalToConstant: 140),
            heroImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            heroImage.bottomAnchor.constraint(equalTo: heroNameLabel.topAnchor, constant: 10),

            heroNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            heroNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            heroNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5),
            heroNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
        
        contentView.backgroundColor = .cellColor
    }
}
