//
//  ErrorView.swift
//  RickMortySystems
//
//  Created by Артём Тюрморезов on 18.08.2023.
//

import Foundation
import UIKit

class ErrorMainScreen: UIView {
    
    private let bannerImageView: UIImageView = {
        let banner = UIImageView()
        banner.image = UIImage(systemName: "pencil.slash")?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        banner.translatesAutoresizingMaskIntoConstraints = false
        return banner
    }()
    
    private let labelView: UILabel = {
        let label = UILabel()
        label.textColor = .systemPink
        label.layer.borderWidth = 1
        label.numberOfLines = 0
        label.text = "No internet connection awailable"
        label.layer.borderColor = UIColor.systemPink.withAlphaComponent(0.2).cgColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Setup UI
    func setupUI() {
        addSubview(bannerImageView)
        addSubview(labelView)
        
        NSLayoutConstraint.activate([
            bannerImageView.widthAnchor.constraint(equalToConstant: 50),
            bannerImageView.heightAnchor.constraint(equalToConstant: 50),
            bannerImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bannerImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50),
            
            labelView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 26),
            labelView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -26),
            labelView.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: 16),
            labelView.heightAnchor.constraint(equalToConstant: 100)
            
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
