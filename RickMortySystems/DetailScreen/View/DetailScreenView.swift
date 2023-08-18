//
//  DetailScreenView.swift
//  RickMortySystems
//
//  Created by Артём Тюрморезов on 17.08.2023.
//

import Foundation
import SwiftUI

//  я решил таким способом сделать 2 вьюконтроллер

class SwiftUIViewController: UIHostingController<DetailScreenView> {
    
    init(viewModel: DetailViewModel) {
        let rootView = DetailScreenView(viewModel: viewModel)
        super.init(rootView: rootView)
    }
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct DetailScreenView: View {
    
    @ObservedObject var viewModel: DetailViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                
                // MARK: - Profile
                
                ProfileView(imageName: viewModel.model.image, name: viewModel.model.name, status: viewModel.model.status, isLoading: viewModel.isLoaded)
                    .padding([.leading, .trailing, .bottom])
                
                // MARK: - Info
                
                InfoView(species: viewModel.model.species, type: viewModel.model.type, gender: viewModel.model.gender, isLoading: viewModel.isLoaded)
                    .padding(.all)

                // MARK: - Origin
                
                OriginView(name: viewModel.origin.name, type: viewModel.origin.type, isLoading: viewModel.isLoaded)
                    .padding(.all)
                
                // MARK: - Episodes
                
                EpisodesView(viewModel: viewModel)
                    .padding(.all)
                
            }.onAppear {
                viewModel.configureData()
            }
        }
        .background(Color.init(uiColor: .bgColor))
    }
}
