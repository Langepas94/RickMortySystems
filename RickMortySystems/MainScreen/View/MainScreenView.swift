//
//  ViewController.swift
//  RickMortySystems
//
//  Created by Артём Тюрморезов on 17.08.2023.
//

import UIKit
import Combine

enum Section: String, CaseIterable {
    case main = "skills"
}

final class MainScreenView: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var mainCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero,
                                          collectionViewLayout: createCompositionalLayout())
        collection.delegate = self
        collection.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(MainScreenCollectionCell.self, forCellWithReuseIdentifier: MainScreenCollectionCell.reuseID)
        collection.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Header.reuseID)
        collection.frame = view.bounds
        collection.backgroundColor = .bgColor
        return collection
    }()
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, HeroModelDataObject>! = nil

    private var cancellables = Set<AnyCancellable>()

    private lazy var errorView: ErrorMainScreen = {
        let errorView = ErrorMainScreen()
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.isHidden = true
        return errorView
    }()
    
    private lazy var loadingSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    // MARK - Public properties
    
    public var viewModel: any MainScreenViewModelProtocol {
        didSet {
            bind(viewModel: viewModel )
        }
    }
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureDataSource()
        bind(viewModel: self.viewModel)
    }
    
    // MARK: - createCompositionalLayout()
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout(section: mainLayoutSection())
    }
    
    private func mainLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(0.26))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        section.contentInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    // MARK: - Private methods
    
    private func bind(viewModel: any MainScreenViewModelProtocol) {
        guard let viewModel = viewModel as? MainScreenViewModel else {
            return
        }
        viewModel.$state.removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.render(state: state)
            }.store(in: &cancellables)
        DispatchQueue.main.async {
            self.viewModel.send(event: .onAppear)
        }
    }
    
    private func render(state: State) {
        switch state {
        case .idle:
            break
        case .loading:
            self.loadingSpinner.startAnimating()
        case .loaded:
            configureDataSource()
            errorView.isHidden = true
            self.loadingSpinner.stopAnimating()
            self.mainCollection.reloadData()
        case .error:
            errorView.isHidden = false
            self.mainCollection.reloadData()
        }
    }
    
    // MARK: Init
    
    init(viewModel: any MainScreenViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - DataSource

extension MainScreenView {
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource
        <Section, HeroModelDataObject>(collectionView: mainCollection) {
            (collectionView: UICollectionView, indexPath: IndexPath, hero: HeroModelDataObject) -> UICollectionViewCell? in
            let sectionType = Section.allCases[indexPath.section]
            switch sectionType {
            case .main:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainScreenCollectionCell.reuseID, for: indexPath) as! MainScreenCollectionCell
                cell.configure(hero)
                return cell
            }
        }
        
        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let self = self else { return nil }
            if kind == UICollectionView.elementKindSectionHeader {
                let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: Header.reuseID,
                    for: indexPath) as! Header
                return headerView
            } else {
                return nil
            }
        }
        
        let snapshot = snapshotForCurrentState()
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<Section, HeroModelDataObject> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, HeroModelDataObject>()
        let allHeroes = viewModel.getModel()
        snapshot.appendSections([Section.main])
        snapshot.appendItems(allHeroes)
        return snapshot
    }
}

// MARK: - SetupUI

extension MainScreenView {
    
    func setupUI() {
        view.addSubview(errorView)
        view.addSubview(mainCollection)
        view.addSubview(loadingSpinner)
        
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: view.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingSpinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingSpinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingSpinner.heightAnchor.constraint(equalToConstant: 100),
            loadingSpinner.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}

// MARK: - Delegate

extension MainScreenView: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let height = scrollView.contentSize.height
        if offsetY > height - scrollView.frame.height {
            self.viewModel.send(event: .onPageScroll)
            configureDataSource()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.send(event: .onDetailScreen(indexPath.item))
    }
}
